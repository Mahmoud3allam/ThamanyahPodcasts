//
//  APIRequestResponseLog.swift
//  ThmanyahPodcasts
//
//  Created Mahmoud Allam on 23/11/2023.
//  Copyright © 2023 https://github.com/Mahmoud3allam. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
import Alamofire
import Foundation

final class APIRequestResponseLog: EventMonitor {
    func requestDidFinish(_ request: Request) {
        printRequest(request: request)
    }

    func request<Value>(_: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        guard let data = response.data else {
            return
        }
        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
            debugPrint("====================")
            debugPrint("Request Response")
            debugPrint(json)
        } else {
            debugPrint(BaseAPIRequestResponseFailureErrorType.parse.message)
        }
    }

    func request(_ request: Request, didFailTask _: URLSessionTask, earlyWithError _: AFError) {
        printRequest(request: request)
    }

    private func printRequest(request: Request) {
        debugPrint("====================")
        debugPrint("Request URL & method")
        debugPrint(request.description)
        debugPrint("====================")
        debugPrint("Request Headers")
        let headers = request.request?.allHTTPHeaderFields ?? ["": ""]
        debugPrint(headers)
        debugPrint("====================")
        debugPrint("Request Parameters")
        if let parameters = request.request?.httpBody {
            let httpBody = String(decoding: parameters, as: UTF8.self)
            debugPrint(httpBody)
        }
    }
}
