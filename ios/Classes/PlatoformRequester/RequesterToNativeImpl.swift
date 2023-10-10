//
//  PlatformRequester.swift
//  amazon_chime_plugin
//
//  Created by Yugo Sugiyama on 2023/08/17.
//

import Foundation
import AVFoundation
import Flutter
import AmazonChimeSDK

final class RequesterToNativeImpl: RequesterToNative {
    func getPlatformVersion(completion: @escaping (Result<String, Error>) -> Void) {
        Task {
            completion(.success(await UIDevice.current.systemVersion))
        }
    }

    func requestMicrophonePermissions(completion: @escaping (Result<String, Error>) -> Void) {
        Task {
            do {
                completion(.success((try await requestMicrophonePermission()).rawValue))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func requestCameraPermissions(completion: @escaping (Result<String, Error>) -> Void) {
        Task {
            do {
                completion(.success((try await requestCameraPermission()).rawValue))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func initialAudioSelection(completion: @escaping (Result<String, Error>) -> Void) {
        if let initialAudioDevice = MeetingSession.shared.meetingSession?.audioVideo.getActiveAudioDevice() {
            completion(.success(initialAudioDevice.label))
        } else {
            completion(.failure(AmazonChimeError.responseMessage(type: .failedToGetInitialMicrophoneDevice).asFlutterError))
        }
    }

    func listAudioDevices(completion: @escaping (Result<[String], Error>) -> Void) {
        if let audioDevices = MeetingSession.shared.meetingSession?.audioVideo.listAudioDevices() {
            completion(.success(audioDevices.map(\.label)))
        } else {
            completion(.failure(AmazonChimeError.responseMessage(type: .failedToListMicrophoneDevices).asFlutterError))
        }
    }

    func updateCurrentDevice(deviceLabel: String, completion: @escaping (Result<String, Error>) -> Void) {
        if let audioDevices = MeetingSession.shared.meetingSession?.audioVideo.listAudioDevices() {
            if let device = audioDevices.first(where: { $0.label == deviceLabel }) {
                MeetingSession.shared.meetingSession?.audioVideo.chooseAudioDevice(mediaDevice: device)
                completion(.success(ResponseMessageKind.microphoneDeviceUpdated.rawValue))
            } else {
                completion(.failure(AmazonChimeError.responseMessage(type: .microphoneDeviceUpdateFailed)))
            }
        } else {
            MeetingSession.shared.meetingSession?.logger.error(msg: ResponseMessageKind.failedToListMicrophoneDevices.rawValue)
            completion(.failure(AmazonChimeError.responseMessage(type: .failedToListMicrophoneDevices).asFlutterError))
        }
    }

    func startLocalVideo(completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try MeetingSession.shared.meetingSession?.audioVideo.startLocalVideo()
                completion(.success(()))
            } catch {
                MeetingSession.shared.meetingSession?.logger.error(msg: "Error configuring AVAudioSession: \(error.localizedDescription)")
                completion(.failure(AmazonChimeError.customError(text: "Failed to start local video").asFlutterError))
            }
        }
    }

    func stopLocalVideo(completion: @escaping (Result<Void, Error>) -> Void) {
        MeetingSession.shared.meetingSession?.audioVideo.stopLocalVideo()
        completion(.success(()))
    }

    func join(parameter: JoinParameter, completion: @escaping (Result<Void, Error>) -> Void) {
        let meetingResponse = CreateMeetingResponse(
            meeting: Meeting(
                externalMeetingId: parameter.externalMeetingId,
                mediaPlacement: MediaPlacement(
                    audioFallbackUrl: parameter.audioFallbackUrl,
                    audioHostUrl: parameter.audioHostUrl,
                    signalingUrl: parameter.signalingUrl,
                    turnControlUrl: parameter.turnControlUrl
                ),
                mediaRegion: parameter.mediaRegion,
                meetingId: parameter.meetingId
            )
        )

        let attendeeResponse = CreateAttendeeResponse(
            attendee: Attendee(
                attendeeId: parameter.attendeeId,
                externalUserId: parameter.externalUserId,
                joinToken: parameter.joinToken
            )
        )

        let meetingSessionConfiguration = MeetingSessionConfiguration(
            createMeetingResponse: meetingResponse,
            createAttendeeResponse: attendeeResponse
        )

        let logger = ConsoleLogger(
            name: "MeetingSession Logger",
            level: LogLevel.DEBUG
        )

        let meetingSession = DefaultMeetingSession(
            configuration: meetingSessionConfiguration,
            logger: logger
        )

        self.configureAudioSession()

        // Update Singleton Class
        MeetingSession.shared.setSession(session: meetingSession)

        setupAudioVideoFacadeObservers()
        MeetingSession.shared.meetingSession?.audioVideo.addVideoTileObserver(observer: self)
        do {
            try MeetingSession.shared.startMeetingAudio()
            completion(.success(()))
        } catch {
            completion(.failure(AmazonChimeError.customError(text: "Failed to set up meeting audio! \(error.localizedDescription)").asFlutterError))
        }
    }

    func stop(completion: @escaping (Result<Void, Error>) -> Void) {
        if let meetingSession = MeetingSession.shared.meetingSession {
            meetingSession.audioVideo.stop()
            MeetingSession.shared.removeSession()
            completion(.success(()))
        } else {
            completion(.failure(AmazonChimeError.customError(text: "Meeting session is nil")))
        }
    }

    func mute(completion: @escaping (Result<Void, Error>) -> Void) {
        let muted = MeetingSession.shared.meetingSession?.audioVideo.realtimeLocalMute() ?? false

        if muted {
            completion(.success(()))
        } else {
            completion(.failure(AmazonChimeError.customError(text: "Failed to mute!").asFlutterError))
        }
    }

    func unmute(completion: @escaping (Result<Void, Error>) -> Void) {
        let unmuted = MeetingSession.shared.meetingSession?.audioVideo.realtimeLocalUnmute() ?? false

        if unmuted {
            completion(.success(()))
        } else {
            completion(.failure(AmazonChimeError.customError(text: "Failed to unmute").asFlutterError))
        }
    }
}

private extension RequesterToNativeImpl {
    func requestMicrophonePermission() async throws -> ResponseMessageKind {
        func requestMicrophonePermission() async -> Bool {
            return await withCheckedContinuation { continuation in
                AVAudioSession.sharedInstance().requestRecordPermission { granted in
                    continuation.resume(returning: granted)
                }
            }
        }

        let microphonePermission = AVAudioSession.sharedInstance().recordPermission
        switch microphonePermission {
        case .undetermined:
            if await requestMicrophonePermission() {
                return .microphoneAuthorized
            } else {
                throw AmazonChimeError.responseMessage(type: .microphoneAuthNotGranted)
            }
        case .granted:
            return .microphoneAuthorized
        case .denied:
            throw AmazonChimeError.responseMessage(type: .microphoneAuthNotGranted)
        @unknown default:
            throw AmazonChimeError.responseMessage(type: .unknownMicrophoneAuthorizationStatus)
        }
    }

    func requestCameraPermission() async throws -> ResponseMessageKind {
        func requestCameraPermission() async -> Bool {
            return await withCheckedContinuation { continuation in
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    continuation.resume(returning: granted)
                }
            }
        }

        let cameraPermission = AVCaptureDevice.authorizationStatus(for: .video)
        switch cameraPermission {
        case .notDetermined:
            if await requestCameraPermission() {
                return .cameraAuthorized
            } else {
                throw AmazonChimeError.responseMessage(type: .cameraAuthNotGranted)
            }
        case .authorized:
            return .cameraAuthorized
        case .denied, .restricted:
            throw AmazonChimeError.responseMessage(type: .cameraAuthNotGranted)
        @unknown default:
            throw AmazonChimeError.responseMessage(type: .unknownCameraAuthorizationStatus)
        }
    }

    private func configureAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            if audioSession.category != .playAndRecord {
                try audioSession.setCategory(AVAudioSession.Category.playAndRecord,
                                             options: AVAudioSession.CategoryOptions.allowBluetooth)
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            }
            if audioSession.mode != .voiceChat {
                try audioSession.setMode(.voiceChat)
            }
        } catch {
            MeetingSession.shared.meetingSession?.logger.error(msg: "Error configuring AVAudioSession: \(error.localizedDescription)")
        }
    }

    private func setupAudioVideoFacadeObservers() {
        // TODO: implement
        //        self.realtimeObserver = MyRealtimeObserver(withMethodChannel: self)
//                if realtimeObserver !=
        MeetingSession.shared.meetingSession?.audioVideo.addRealtimeObserver(observer: self)
        //            MeetingSession.shared.meetingSession?.logger.info(msg: "realtimeObserver set up...")
        //        }
        //
        //        self.audioVideoObserver = MyAudioVideoObserver(withMethodChannel: self)
        //        if self.audioVideoObserver != nil {
        //            MeetingSession.shared.meetingSession?.audioVideo.addAudioVideoObserver(observer: self.audioVideoObserver!)
        //            MeetingSession.shared.meetingSession?.logger.info(msg: "audioVideoObserver set up...")
        //        }
        //
        //        self.videoTileObserver = MyVideoTileObserver(withMethodChannel: self)
        //        if self.videoTileObserver != nil {
        //            MeetingSession.shared.meetingSession?.audioVideo.addVideoTileObserver(observer: self.videoTileObserver!)
        //            MeetingSession.shared.meetingSession?.logger.info(msg: "VideoTileObserver set up...")
        //        }
    }
}


extension RequesterToNativeImpl: RealtimeObserver {
    public func volumeDidChange(volumeUpdates: [VolumeUpdate]) {
    }

    public func signalStrengthDidChange(signalUpdates: [SignalUpdate]) {
    }

    public func attendeesDidJoin(attendeeInfo: [AttendeeInfo]) {
        for currentAttendeeInfo in attendeeInfo {
            let info = ParticipantInfo(
                attendeeId: currentAttendeeInfo.attendeeId,
                externalUserId: currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.joined(info: info, completion: {})
        }
    }

    public func attendeesDidLeave(attendeeInfo: [AttendeeInfo]) {
        for currentAttendeeInfo in attendeeInfo {
            let info = ParticipantInfo(
                attendeeId: currentAttendeeInfo.attendeeId,
                externalUserId: currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.left(info: info, completion: {})
        }
    }

    public func attendeesDidDrop(attendeeInfo: [AttendeeInfo]) {
        for currentAttendeeInfo in attendeeInfo {
            let info = ParticipantInfo(
                attendeeId: currentAttendeeInfo.attendeeId,
                externalUserId: currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.dropped(info: info, completion: {})
        }
    }

    public func attendeesDidMute(attendeeInfo: [AttendeeInfo]) {
        for currentAttendeeInfo in attendeeInfo {
            let info = ParticipantInfo(
                attendeeId: currentAttendeeInfo.attendeeId,
                externalUserId: currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.muted(info: info, completion: {})
        }
    }

    public func attendeesDidUnmute(attendeeInfo: [AttendeeInfo]) {
        for currentAttendeeInfo in attendeeInfo {
            let info = ParticipantInfo(
                attendeeId: currentAttendeeInfo.attendeeId,
                externalUserId: currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.unmuted(info: info, completion: {})
        }
    }
}

extension RequesterToNativeImpl: VideoTileObserver {
    func videoTileDidAdd(tileState: AmazonChimeSDK.VideoTileState) {
        let info = TileInfo(
            tileId: Int64(exactly: tileState.tileId)!,
            attendeeId: tileState.attendeeId,
            videoStreamContentWidth: Double(tileState.videoStreamContentWidth),
            videoStreamContentHeight: Double(tileState.videoStreamContentHeight),
            isLocalTile: tileState.isLocalTile,
            isContent: tileState.isContent
        )
        AmazonChimePlugin.requester?.videoTileAdded(info: info, completion: {})
    }

    func videoTileDidRemove(tileState: AmazonChimeSDK.VideoTileState) {
        let info = TileInfo(
            tileId: Int64(exactly: tileState.tileId)!,
            attendeeId: tileState.attendeeId,
            videoStreamContentWidth: Double(tileState.videoStreamContentWidth),
            videoStreamContentHeight: Double(tileState.videoStreamContentHeight),
            isLocalTile: tileState.isLocalTile,
            isContent: tileState.isContent
        )
        AmazonChimePlugin.requester?.videoTileRemoved(info: info, completion: {})
    }

    func videoTileDidPause(tileState: AmazonChimeSDK.VideoTileState) {

    }

    func videoTileDidResume(tileState: AmazonChimeSDK.VideoTileState) {

    }

    func videoTileSizeDidChange(tileState: AmazonChimeSDK.VideoTileState) {

    }
}
