//
//  MeetingSession.swift
//  amazon_chime_plugin
//
//  Created by Yugo Sugiyama on 2023/08/29.
//

import AmazonChimeSDK
import AmazonChimeSDKMedia
import AVFoundation
import Flutter
import Foundation

final class MeetingSession {
    static let shared = MeetingSession()

    private(set) var meetingSession: DefaultMeetingSession?

    let audioVideoConfig = AudioVideoConfiguration()
    private let logger = ConsoleLogger(name: "MeetingSession")

    private init() {}

    func setSession(session: DefaultMeetingSession) {
        meetingSession = session
    }

    func removeSession() {
        meetingSession = nil
    }

    func startMeetingAudio() throws {
        // TODO: fix bug audio setting error
        try configureAudioSession()
        try startAudioVideoConnection()
        // Remove background noise
        // Ref: https://github.com/aws/amazon-chime-sdk-ios?tab=readme-ov-file#amazon-voice-focus
        _ = meetingSession?.audioVideo.realtimeSetVoiceFocusEnabled(enabled: true)
    }
}

private extension MeetingSession {
    func configureAudioSession() throws {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .videoRecording, options: [.allowBluetooth, .defaultToSpeaker])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            logger.error(msg: "Error configuring AVAudioSession: \(error.localizedDescription)")
            throw AmazonChimeError.customError(text: error.localizedDescription)
        }
    }

    func startAudioVideoConnection() throws {
        do {
            try meetingSession?.audioVideo.start()
            meetingSession?.audioVideo.startRemoteVideo()
        } catch PermissionError.audioPermissionError {
            throw AmazonChimeError.customError(text: PermissionError.audioPermissionError.localizedDescription)
        } catch {
            throw AmazonChimeError.customError(text: error.localizedDescription)
        }
    }
}
