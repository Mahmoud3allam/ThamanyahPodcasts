//
//  BaseAPIRequestResponseBusinessErrorType.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 23/11/2023.
//

enum BaseAPIRequestResponseBusinessErrorType: Error {
    case somethingWentWrong

    var message: String {
        switch self {
        case .somethingWentWrong: return "Something went wrong, please try again"
        }
    }
}
