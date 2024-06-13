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
    let textureRegistry: FlutterTextureRegistry
    let localCameraController = LocalCameraController()

    init(textureRegistry: FlutterTextureRegistry) {
        self.textureRegistry = textureRegistry
    }

    func getPlatformVersion(completion: @escaping (Result<String, Error>) -> Void) {
        Task {
            completion(.success(await UIDevice.current.systemVersion))
        }
    }

    func getActiveAudioDevice(completion: @escaping (Result<String, Error>) -> Void) {
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

    func startLocalVideo(completion: @escaping (Result<Void, any Error>) -> Void) {
        let videoSource = LocalCameraSource(localCameraController: localCameraController)
        localCameraController.startRunning()
        MeetingSession.shared.meetingSession?.audioVideo.startLocalVideo(source: videoSource)
        completion(.success(()))
    }

    func stopLocalVideo(completion: @escaping (Result<Void, any Error>) -> Void) {
        localCameraController.stopRunning()
        MeetingSession.shared.meetingSession?.audioVideo.stopLocalVideo()
        completion(.success(()))
    }

    func startRemoteVideo(completion: @escaping (Result<Void, any Error>) -> Void) {
        MeetingSession.shared.meetingSession?.audioVideo.startRemoteVideo()
        completion(.success(()))
    }

    func stopRemoteVideo(completion: @escaping (Result<Void, any Error>) -> Void) {
        MeetingSession.shared.meetingSession?.audioVideo.stopRemoteVideo()
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
            meetingSession.audioVideo.stopLocalVideo()
            meetingSession.audioVideo.stopRemoteVideo()
            meetingSession.audioVideo.stop()
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
        DispatchQueue.global(qos: .userInitiated).async {
            self.localCameraController.switchCamera()
            completion(.success(()))
        }
    }

    func createTileTexture(tileId: Int64, completion: @escaping (Result<Int64, any Error>) -> Void) {
        let controller = VideoTileTextureController(tileId: Int(tileId), registrar: textureRegistry)
        let textureId = controller.textureId
        AmazonChimePlugin.videoTileTextureControllers[tileId] = controller
        completion(.success(textureId))
    }

    func disposeTileTexture(tileId: Int64, completion: @escaping (Result<Int64, any Error>) -> Void) {
        let controller = AmazonChimePlugin.videoTileTextureControllers.first(where: { $0.key == tileId })?.value
        controller?.dispose()
        AmazonChimePlugin.videoTileTextureControllers.removeValue(forKey: tileId)
    }
}

private extension RequesterToNativeImpl {
    private func configureAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .videoRecording, options: [.allowBluetooth, .defaultToSpeaker])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
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

    public func attendeesDidJoin(attendeeInfo: [AmazonChimeSDK.AttendeeInfo]) {
        for currentAttendeeInfo in attendeeInfo {
            let info = AttendeeInfo(
                attendeeId: currentAttendeeInfo.attendeeId,
                externalUserId: currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.joined(info: info, completion: { _ in })
        }
    }

    public func attendeesDidLeave(attendeeInfo: [AmazonChimeSDK.AttendeeInfo]) {
        for currentAttendeeInfo in attendeeInfo {
            let info = AttendeeInfo(
                attendeeId: currentAttendeeInfo.attendeeId,
                externalUserId: currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.left(info: info, completion: { _ in })
        }
    }

    public func attendeesDidDrop(attendeeInfo: [AmazonChimeSDK.AttendeeInfo]) {
        for currentAttendeeInfo in attendeeInfo {
            let info = AttendeeInfo(
                attendeeId: currentAttendeeInfo.attendeeId,
                externalUserId: currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.dropped(info: info, completion: { _ in })
        }
    }

    public func attendeesDidMute(attendeeInfo: [AmazonChimeSDK.AttendeeInfo]) {
        for currentAttendeeInfo in attendeeInfo {
            let info = AttendeeInfo(
                attendeeId: currentAttendeeInfo.attendeeId,
                externalUserId: currentAttendeeInfo.externalUserId
            )
            AmazonChimePlugin.requester?.muted(info: info, completion: { _ in })
        }
    }

    public func attendeesDidUnmute(attendeeInfo: [AmazonChimeSDK.AttendeeInfo]) {
        for currentAttendeeInfo in attendeeInfo {
            let info = AttendeeInfo(
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
        AmazonChimePlugin.requester?.audioSessionDidStartConnecting(reconnecting: reconnecting, completion: { _ in })
    }

    func audioSessionDidStart(reconnecting: Bool) {
        AmazonChimePlugin.requester?.audioSessionDidStart(reconnecting: reconnecting, completion: { _ in })
    }

    func audioSessionDidDrop() {
        AmazonChimePlugin.requester?.audioSessionDidDrop(completion: { _ in })
    }

    func audioSessionDidStopWithStatus(sessionStatus: AmazonChimeSDK.MeetingSessionStatus) {
    }

    func audioSessionDidCancelReconnect() {
        AmazonChimePlugin.requester?.audioSessionDidCancelReconnect(completion: { _ in })
    }

    func connectionDidRecover() {
        AmazonChimePlugin.requester?.connectionDidRecover(completion: { _ in })
    }

    func connectionDidBecomePoor() {
        AmazonChimePlugin.requester?.connectionDidBecomePoor(completion: { _ in })
    }

    func videoSessionDidStartConnecting() {
        AmazonChimePlugin.requester?.videoSessionDidStartConnecting(completion: { _ in })
    }

    func videoSessionDidStartWithStatus(sessionStatus: AmazonChimeSDK.MeetingSessionStatus) {
    }

    func videoSessionDidStopWithStatus(sessionStatus: AmazonChimeSDK.MeetingSessionStatus) {
    }

    func remoteVideoSourcesDidBecomeAvailable(sources: [AmazonChimeSDK.RemoteVideoSource]) {
        AmazonChimePlugin.requester?.remoteVideoSourcesDidBecomeAvailable(sources: sources.map(\.attendeeId), completion: { _ in })
    }

    func remoteVideoSourcesDidBecomeUnavailable(sources: [AmazonChimeSDK.RemoteVideoSource]) {
        AmazonChimePlugin.requester?.remoteVideoSourcesDidBecomeUnavailable(sources: sources.map(\.attendeeId), completion: { _ in })
    }

    func cameraSendAvailabilityDidChange(available: Bool) {
        AmazonChimePlugin.requester?.cameraSendAvailabilityDidChange(available: available, completion: { _ in })
    }
}
