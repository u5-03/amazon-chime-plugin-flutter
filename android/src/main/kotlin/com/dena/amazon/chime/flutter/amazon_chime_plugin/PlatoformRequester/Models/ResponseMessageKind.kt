package com.dena.amazon.chime.flutter.amazon_chime_plugin.PlatoformRequester.Models

enum class ResponseMessageKind(val rawValue: String) {
    // Authorization
    MICROPHONE_AUTHORIZED("Android: Microphone authorized."),
    CAMERA_AUTHORIZED("Android: Camera authorized."),
    CAMERA_AUTH_NOT_GRANTED("Android: ERROR camera authorization not granted."),
    MICROPHONE_AUTH_NOT_GRANTED("Android: ERROR audio authorization not granted."),
    MICROPHONE_RESTRICTED("Android: ERROR audio restricted."),
    CAMERA_RESTRICTED("Android: ERROR camera restricted."),
    UNKNOWN_MICROPHONE_AUTHORIZATION_STATUS("Android: ERROR unknown audio authorization status."),
    UNKNOWN_CAMERA_AUTHORIZATION_STATUS("Android: ERROR unknown camera authorization status."),

    // Meeting
    INCORRECT_JOIN_RESPONSE_PARAMS("Android: ERROR api response has incorrect/missing parameters."),
    CREATE_MEETING_SUCCESS("Android: meetingSession created successfully."),
    CREATE_MEETING_FAILED("Android: ERROR failed to create meetingSession."),
    MEETING_START_FAILED("Android: ERROR failed to start meeting."),
    MEETING_STOPPED_SUCCESSFULLY("Android: meetingSession stopped successfuly."),
    MEETING_SESSION_IS_NULL("Android: ERROR Meeting session is null."),

    // Mute
    MUTE_SUCCESSFUL("Android: Successfully muted user"),
    MUTE_FAILED("Android: Could not mute user"),
    UNMUTE_SUCCESSFUL("Android: Successfully unmuted user"),
    UNMUTE_FAILED("Android: ERROR Could not unmute user"),

    // Camera
    LOCAL_CAMERA_ON_SUCCESS("Android: Started local camera."),
    LOCAL_CAMERA_ON_FAILED("Android: ERROR could not start local camera."),
    LOCAL_CAMERA_OFF_SUCCESS("Android: Stopped local camera."),

    // Microphone Device
    MICROPHONE_DEVICE_UPDATED("Android: Microphone device updated."),
    FAILED_TO_GET_INITIAL_MICROPHONE_DEVICE("Android: Failed to get initial audio device"),
    MICROPHONE_DEVICE_UPDATE_FAILED("Android: Failed to update audio device."),
    FAILED_TO_LIST_MICROPHONE_DEVICES("Android: ERROR failed to list audio devices."),

    // Method Channel
    METHOD_NOT_IMPLEMENTED("Android: ERROR method not implemented.")
}
