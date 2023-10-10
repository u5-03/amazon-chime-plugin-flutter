//
//  ResponseMessage.swift
//  amazon_chime_plugin
//
//  Created by Yugo Sugiyama on 2023/08/17.
//

import Foundation

enum ResponseMessageKind: String {
    // Authorization
    case microphoneAuthorized = "iOS: Microphone authorized."
    case cameraAuthorized = "iOS: Camera authorized."
    case cameraAuthNotGranted = "iOS: ERROR camera authorization not granted."
    case microphoneAuthNotGranted = "iOS: ERROR microphone authorization not granted."
    case microphoneRestricted = "iOS: ERROR microphone restricted."
    case cameraRestricted = "iOS: ERROR camera restricted."
    case unknownMicrophoneAuthorizationStatus = "iOS: ERROR unknown microphone authorization status."
    case unknownCameraAuthorizationStatus = "iOS: ERROR unknown camera authorization status."

    // Meeting
    case incorrectJoinResponseParams = "iOS: ERROR api response has incorrect/missing parameters."
    case createMeetingSuccess = "iOS: meetingSession created successfully."
    case createMeetingFailed = "iOS: ERROR failed to create meetingSession."
    case meetingStartFailed = "iOS: ERROR failed to start meeting."
    case meetingStoppedSuccessfully = "iOS: meetingSession stopped successfuly."

    // Mute
    case muteSuccessful = "iOS: Successfully muted user"
    case muteFailed = "iOS: Could not mute user"
    case unmuteSuccessful = "iOS: Successfully unmuted user"
    case unmuteFailed = "iOS: ERROR Could not unmute user"

    // Camera
    case localCameraOnSuccess = "iOS: Started local camera."
    case localCameraOnFailed = "iOS: ERROR could not start local camera."
    case localCameraOffSuccess = "iOS: Stopped local camera."

    // Microphone Device
    case microphoneDeviceUpdated = "iOS: Microphone device updated."
    case failedToGetInitialMicrophoneDevice = "iOS: Failed to get initial microphone device"
    case microphoneDeviceUpdateFailed = "iOS: Failed to update microphone device."
    case failedToListMicrophoneDevices = "iOS: ERROR failed to list microphone devices."

    // Method Channel
    case methodNotImplemented = "iOS: ERROR method not implemented."
}
