//
//  ResponseMessageData.swift
//  amazon_chime_plugin
//
//  Created by Yugo Sugiyama on 2023/08/17.
//

import Foundation

struct ResponseMessageData {
    let result: Bool
    let type: ResponseMessage

    var asStringData: StringData {
        StringData(result: result, data: type.rawValue)
    }
}
