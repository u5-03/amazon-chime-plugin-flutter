//
//  AmazonChimeError.swift
//  amazon_chime_plugin
//
//  Created by Yugo Sugiyama on 2023/08/31.
//

import Foundation
import Flutter

extension FlutterError: Error {}

enum AmazonChimeError: Error {
    case invalidResponse
    case responseMessage(type: ResponseMessageKind)
    case customError(text: String)

    private var errorType: AmazonChimeErrorType {
        switch self {
        case .invalidResponse:
            return .invalidResponse
        case .responseMessage:
            return .responseMessage
        case .customError:
            return .customError
        }
    }

    var asFlutterError: FlutterError {
        let code = String(errorType.rawValue)
        switch self {
        case .invalidResponse:
            return FlutterError(code: code, message: nil, details: nil)
        case .responseMessage(let type):
            return FlutterError(code: code, message: type.rawValue, details: nil)
        case .customError(let text):
            return FlutterError(code: code, message: text, details: nil)
        }
    }
}
