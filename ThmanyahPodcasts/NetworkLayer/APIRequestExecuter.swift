//
//  APIRequestExecuter.swift
//  ThmanyahPodcasts
//
//  Created Arab Calibers on 23/11/2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
import Alamofire
import Foundation
class APIRequestExecuter<T: APIRequestBuilder> {
    // MARK: - Base API Function to Call Api..

    private lazy var alamofireSession: Session? = {
        let configuration = URLSessionConfiguration.default
        let apiRequestResponseLog = APIRequestResponseLog()
        let interceptor = APIRequestInterceptor()
        let alamoFireManager = Alamofire.Session(configuration: configuration, interceptor: interceptor, cachedResponseHandler: nil, eventMonitors: [apiRequestResponseLog])
        return alamoFireManager
    }()

    func performRequest<M: Decodable>(target: T, responseClass _: M.Type, completion: @escaping (Swift.Result<M?, BaseAPIRequestResponseFailureErrorType>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let parameters = buildParameters(withTask: target.task)
        let headers = buildHeaders(withHeader: target.headers)
        alamofireSession?.request(target.baseUrl + target.path, method: method, parameters: parameters.0, encoding: parameters.1, headers: headers ?? nil, interceptor: APIRequestInterceptor()).validate().responseJSON { response in
            guard (response.response?.statusCode) != nil else {
                // We Should add Custom Error here...
                completion(.failure(.server))
                return
            }
            switch response.result {
            case .success:
                guard let jsonData = response.data else {
                    // We Should add Custom Error that we can't get Json Data
                    completion(.failure(.parse))
                    return
                }
                do {
                    let responseObject = try JSONDecoder().decode(M.self, from: jsonData)
                    print("🕺 🕺 🕺 🕺 🕺🕺 💪")
                    completion(.success(responseObject))
                } catch {
                    print("😑 😑 😑 😑 😑 😑 😑 😑 😑 😑 😑 😑 😑 😑")
                    completion(.failure(.parse))
                    return
                }
            case let .failure(error):
                print("🚫 🚫 🚫 🚫 🚫 🚫 🚫 🚫 🚫 🚫 🚫 🚫")
                guard let error = error.underlyingError as NSError? else {
                    completion(.failure(BaseAPIRequestResponseFailureErrorType.unknown))
                    return
                }
                completion(.failure(error.code.getAPIRequestResponseFailureError()))
            }
        }
    }

    func performMultiPartRequest<M: Decodable>(target: T, responseClass _: M.Type, completion: @escaping (Swift.Result<M?, BaseAPIRequestResponseFailureErrorType>) -> Void, uploadProgress: @escaping (Double) -> Void) {
        let url = target.baseUrl + target.path
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let parameters = buildParameters(withTask: target.task)
        let actualParams = parameters.0
        let data = parameters.2
        AF.upload(multipartFormData: { multipartFormData in
            if let unwrappedParams = actualParams {
                for (key, value) in unwrappedParams {
                    guard let valueData = "\(value)".data(using: String.Encoding.utf8) else {
                        return
                    }
                    multipartFormData.append(valueData, withName: key as String)
                }
            }

            if let data = data {
                data.forEach { singleData in
                    multipartFormData.append(singleData.dataValue, withName: singleData.dataKey, fileName: singleData.dataKey + singleData.dataExtension.rawValue, mimeType: singleData.dataType.rawValue)
                }
            }
        }, to: url, method: method, headers: nil, interceptor: APIRequestInterceptor()).validate()
            .uploadProgress { progress in
                uploadProgress(progress.fractionCompleted)
            }
            .responseJSON { response in
                guard (response.response?.statusCode) != nil else {
                    // We Should add Custom Error here...
                    completion(.failure(.server))
                    return
                }
                switch response.result {
                case .success:
                    guard let jsonData = response.data else {
                        // We Should add Custom Error that we can't get Json Data
                        completion(.failure(.parse))
                        return
                    }
                    print(jsonData)
                    print(response.response?.statusCode ?? "")
                    do {
                        let responseObject = try JSONDecoder().decode(M.self, from: jsonData)
                        print("🕺 🕺 🕺 🕺 🕺🕺 💪")
                        completion(.success(responseObject))
                    } catch {
                        print("😑 😑 😑 😑 😑 😑 😑 😑 😑 😑 😑 😑 😑 😑")
                        completion(.failure(.parse))
                        return
                    }
                case let .failure(error):
                    print("🚫 🚫 🚫 🚫 🚫 🚫 🚫 🚫 🚫 🚫 🚫 🚫")
                    guard let error = error.underlyingError as NSError? else {
                        completion(.failure(BaseAPIRequestResponseFailureErrorType.unknown))
                        return
                    }
                    completion(.failure(error.code.getAPIRequestResponseFailureError()))
                }
            }
    }

    // MARK: - Build Parameters for  Requests

    private func buildParameters(withTask task: Task) -> ([String: Any]?, ParameterEncoding, [MultiPartData]?) {
        switch task {
        case .normalRequest:
            return (nil, URLEncoding.default, nil)
        case let .WithParametersRequest(parameters: parameters, encoding: encoding):
            return (parameters, encoding, nil)
        case let .multiPartRequest(parameters: params, multiPartData: data, encoding: encoding):
            return (params, encoding, data)
        }
    }

    private func buildHeaders(withHeader headers: [String: String]?) -> HTTPHeaders? {
        if let unwrappedHeaders = headers {
            return HTTPHeaders(unwrappedHeaders)
        }
        return nil
    }
}
