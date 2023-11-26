//
//  APIRequestBuilder.swift
//  ThmanyahPodcasts
//
//  Created Mahmoud Allam on 23/11/2023.
//  Copyright © 2023 https://github.com/Mahmoud3allam. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
import Alamofire
import Foundation

// MARK: - BluePrint For Every Request

protocol APIRequestBuilder {
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: [String: String]? { get }
}

extension APIRequestBuilder {
    var baseUrl: String {
        "https://staging.podcast.kaitdev.com/client/"
    }

    var headers: [String: String]? {
        switch task {
        case .normalRequest, .WithParametersRequest:
            return ["Content-Type": "application/json"]
        case .multiPartRequest:
            return ["application/json": "Accept"]
        }
    }
}

// Method
enum RequestHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// Task
enum Task {
    case normalRequest
    case WithParametersRequest(parameters: [String: Any], encoding: ParameterEncoding)
    case multiPartRequest(parameters: [String: Any]?, multiPartData: [MultiPartData], encoding: ParameterEncoding)
}

struct MultiPartData {
    var dataKey: String
    var dataValue: Data
    var dataType: MultiPartDataType
    var dataExtension: MultiPartDataExtension
}

enum MultiPartDataType: String {
    case imagePng = "image/png"
    case imageJpeg = "image/jpeg"
    case videoMov = "video/mov"
    case videoMp4 = "video/mp4"
    case pdf = "application/pdf"
    case docs = "application/doc"
    case excel = "application/xls"
    case ppt = "application/ppt"
}

enum MultiPartDataExtension: String {
    case png = ".png"
    case jpeg = ".jpeg"
    case mov = ".mov"
    case mp4 = ".mp4"
    case pdf = ".pdf"
    case docs = ".doc"
    case excel = ".xls"
    case ppt = ".ppt"
}
