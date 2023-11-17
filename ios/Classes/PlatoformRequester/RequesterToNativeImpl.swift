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

        setupObservers()

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
            meetingSession.audioVideo.switchCamera()
            removeObservers()
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

    func switchCamera(completion: @escaping (Result<Void, Error>) -> Void) {
        MeetingSession.shared.meetingSession?.audioVideo.switchCamera()
        completion(.success(()))
    }
}

private extension RequesterToNativeImpl {
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

    private func setupObservers() {
        // TODO: implement
        //        self.realtimeObserver = MyRealtimeObserver(withMethodChannel: self)
//                if realtimeObserver !=
        MeetingSession.shared.meetingSession?.audioVideo.addRealtimeObserver(observer: self)
        MeetingSession.shared.meetingSession?.audioVideo.addVideoTileObserver(observer: self)
        MeetingSession.shared.meetingSession?.audioVideo.addAudioVideoObserver(observer: self)
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

    private func removeObservers() {
        MeetingSession.shared.meetingSession?.audioVideo.removeRealtimeObserver(observer: self)
        MeetingSession.shared.meetingSession?.audioVideo.removeVideoTileObserver(observer: self)
        MeetingSession.shared.meetingSession?.audioVideo.removeAudioVideoObserver(observer: self)
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
            AmazonChimePlugin.requester?.joined(info: info, completion: { _ in })
        }
    }

    public func attendeesDidLeave(attendeeInfo: [AttendeeInfo]) {
        for currentAttendeeInfo in attendeeInfo {
            let info = ParticipantInfo(
                attendeeId: currentAttendeeInfo.attendeeId,
                externalUserId: currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.left(info: info, completion: { _ in })
        }
    }

    public func attendeesDidDrop(attendeeInfo: [AttendeeInfo]) {
        for currentAttendeeInfo in attendeeInfo {
            let info = ParticipantInfo(
                attendeeId: currentAttendeeInfo.attendeeId,
                externalUserId: currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.dropped(info: info, completion: { _ in })
        }
    }

    public func attendeesDidMute(attendeeInfo: [AttendeeInfo]) {
        for currentAttendeeInfo in attendeeInfo {
            let info = ParticipantInfo(
                attendeeId: currentAttendeeInfo.attendeeId,
                externalUserId: currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.muted(info: info, completion: { _ in })
        }
    }

    public func attendeesDidUnmute(attendeeInfo: [AttendeeInfo]) {
        for currentAttendeeInfo in attendeeInfo {
            let info = ParticipantInfo(
                attendeeId: currentAttendeeInfo.attendeeId,
                externalUserId: currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.unmuted(info: info, completion: { _ in })
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
        AmazonChimePlugin.requester?.videoTileAdded(info: info, completion: { _ in })
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
        AmazonChimePlugin.requester?.videoTileRemoved(info: info, completion: { _ in })
    }

    func videoTileDidPause(tileState: AmazonChimeSDK.VideoTileState) {

    }

    func videoTileDidResume(tileState: AmazonChimeSDK.VideoTileState) {

    }

    func videoTileSizeDidChange(tileState: AmazonChimeSDK.VideoTileState) {

    }
}

extension RequesterToNativeImpl: AudioVideoObserver {
    func audioSessionDidStartConnecting(reconnecting: Bool) {
    }
    
    func audioSessionDidStart(reconnecting: Bool) {
    }
    
    func audioSessionDidDrop() {
    }
    
    func audioSessionDidStopWithStatus(sessionStatus: AmazonChimeSDK.MeetingSessionStatus) {
        AmazonChimePlugin.requester?.audioSessionDidStop(completion: { _ in })
    }
    
    func audioSessionDidCancelReconnect() {
    }
    
    func connectionDidRecover() {
    }
    
    func connectionDidBecomePoor() {
    }
    
    func videoSessionDidStartConnecting() {
    }
    
    func videoSessionDidStartWithStatus(sessionStatus: AmazonChimeSDK.MeetingSessionStatus) {
    }
    
    func videoSessionDidStopWithStatus(sessionStatus: AmazonChimeSDK.MeetingSessionStatus) {
    }
    
    func remoteVideoSourcesDidBecomeAvailable(sources: [AmazonChimeSDK.RemoteVideoSource]) {
    }
    
    func remoteVideoSourcesDidBecomeUnavailable(sources: [AmazonChimeSDK.RemoteVideoSource]) {
    }
    
    func cameraSendAvailabilityDidChange(available: Bool) {
    }
}
