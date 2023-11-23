//
//  Int+HTTPStatusCode.swift
//  ThmanyahPodcasts
//
//  Created Arab Calibers on 23/11/2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
extension Int {
    /// Informational - Request received, continuing process.
    var isInformationalHTTPCode: Bool {
        self >= 100 && self < 200
    }

    /// Success - The action was successfully received, understood, and accepted.
    var isSuccessHTTPCode: Bool {
        self >= 200 && self < 300
    }

    /// Redirection - Further action must be taken in order to complete the request.
    var isRedirectionHTTPCode: Bool {
        self >= 300 && self < 400
    }

    /// Client Error - The request contains bad syntax or cannot be fulfilled.
    var isClientErrorHTTPCode: Bool {
        self >= 400 && self < 500
    }

    /// Server Error - The server failed to fulfill an apparently valid request.
    var isServerErrorHTTPCode: Bool {
        self >= 500 && self < 600
    }

    /// Internet Error - The server failed to fulfill an apparently valid request.
    var isInternetErrorHTTPCode: Bool {
        self == -1009 || self == -1001 || self == -1005
    }

    var isParsingFail: Bool {
        self == 4865
    }

    func getAPIRequestResponseFailureError() -> BaseAPIRequestResponseFailureErrorType {
        if self.isRedirectionHTTPCode {
            return BaseAPIRequestResponseFailureErrorType.redirection
        } else if self.isInformationalHTTPCode {
            return BaseAPIRequestResponseFailureErrorType.informational
        } else if self.isClientErrorHTTPCode {
            return BaseAPIRequestResponseFailureErrorType.client
        } else if self.isServerErrorHTTPCode {
            return BaseAPIRequestResponseFailureErrorType.server
        } else if self.isInternetErrorHTTPCode {
            return BaseAPIRequestResponseFailureErrorType.internet
        } else if self.isParsingFail {
            return BaseAPIRequestResponseFailureErrorType.parse
        } else {
            return BaseAPIRequestResponseFailureErrorType.unknown
        }
    }
}
