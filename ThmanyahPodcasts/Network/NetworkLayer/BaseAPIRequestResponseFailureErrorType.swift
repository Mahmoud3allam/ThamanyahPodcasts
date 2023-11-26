//
//  BaseAPIRequestResponseFailureErrorType.swift
//  ThmanyahPodcasts
//
//  Created Mahmoud Allam on 23/11/2023.
//  Copyright © 2023 https://github.com/Mahmoud3allam. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
import Foundation

public enum BaseAPIRequestResponseFailureErrorType: Error {
    case informational
    case redirection
    case client
    case server
    case internet

    // Without Status Code
    case unknown
    case parse

    var message: String {
        switch self {
        case .informational:
            return "informational issue"
        case .redirection:
            return "redirection issue"
        case .client:
            return "client issue"
        case .server:
            return "server issue"
        case .unknown:
            return "unknown issue"
        case .internet:
            return "internet issue"
        case .parse:
            return "parsing issue"
        }
    }
}
