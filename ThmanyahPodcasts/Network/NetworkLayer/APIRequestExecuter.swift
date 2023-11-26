//
//  APIRequestExecuter.swift
//  ThmanyahPodcasts
//
//  Created Mahmoud Allam on 23/11/2023.
//  Copyright © 2023 https://github.com/Mahmoud3allam. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
import Alamofire
import Foundation
class APIRequestExecuter<APIRequest: APIRequestBuilder> {
    // MARK: - Base API Function to Call Api..

    private lazy var alamofireSession: Session? = {
        let configuration = URLSessionConfiguration.default
        let apiRequestResponseLog = APIRequestResponseLog()
        let interceptor = APIRequestInterceptor()
        let alamoFireManager = Alamofire.Session(configuration: configuration, interceptor: interceptor, cachedResponseHandler: nil, eventMonitors: [apiRequestResponseLog])
        return alamoFireManager
    }()

    func performRequest<ResponseModel: Decodable>(
        target: APIRequest,
        responseClass _: ResponseModel.Type,
        completion: @escaping (Swift.Result<ResponseModel?, BaseAPIRequestResponseFailureErrorType>) -> Void
    ) {
        performRequestCommon(
            target: target,
            responseClass: ResponseModel.self,
            completion: completion
        )
    }

    func performMultiPartRequest<M: Decodable>(
        target: APIRequest,
        responseClass _: M.Type,
        completion: @escaping (Swift.Result<M?, BaseAPIRequestResponseFailureErrorType>) -> Void,
        uploadProgress: @escaping (Double) -> Void
    ) {
        let url = target.baseUrl + target.path
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let parametersBuilder = buildParameters(withTask: target.task)

        AF.upload(
            multipartFormData: { multipartFormData in
                self.addParametersToMultipartFormData(parametersBuilder.parameters, multipartFormData)
                self.addDataToMultipartFormData(parametersBuilder.multiPartData, multipartFormData)
            },
            to: url,
            method: method,
            headers: nil,
            interceptor: APIRequestInterceptor()
        )
        .validate()
        .uploadProgress { progress in
            uploadProgress(progress.fractionCompleted)
        }
        .responseJSON { response in
            self.handleResponse(response, completion: completion)
        }
    }

    // Common logic for handling responses
    private func handleResponse<M: Decodable>(
        _ response: AFDataResponse<Any>,
        completion: @escaping (Swift.Result<M?, BaseAPIRequestResponseFailureErrorType>) -> Void
    ) {
        guard let statusCode = response.response?.statusCode else {
            completion(.failure(.server))
            return
        }

        switch response.result {
        case .success:
            guard let jsonData = response.data else {
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

    // Common logic for adding parameters to multipart form data
    private func addParametersToMultipartFormData(
        _ parameters: [String: Any]?,
        _ multipartFormData: MultipartFormData
    ) {
        guard let unwrappedParams = parameters else { return }

        for (key, value) in unwrappedParams {
            guard let valueData = "\(value)".data(using: .utf8) else {
                continue
            }
            multipartFormData.append(valueData, withName: key)
        }
    }

    // Common logic for adding data to multipart form data
    private func addDataToMultipartFormData(
        _ data: [MultiPartData]?,
        _ multipartFormData: MultipartFormData
    ) {
        guard let unwrappedData = data else { return }

        for singleData in unwrappedData {
            multipartFormData.append(
                singleData.dataValue,
                withName: singleData.dataKey,
                fileName: singleData.dataKey + singleData.dataExtension.rawValue,
                mimeType: singleData.dataType.rawValue
            )
        }
    }

    // Common logic for handling both types of requests
    private func performRequestCommon<M: Decodable>(
        target: APIRequest,
        responseClass _: M.Type,
        completion: @escaping (Swift.Result<M?, BaseAPIRequestResponseFailureErrorType>) -> Void
    ) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let parametersBuilder = buildParameters(withTask: target.task)
        let headers = buildHeaders(withHeader: target.headers)

        alamofireSession?.request(
            target.baseUrl + target.path,
            method: method,
            parameters: parametersBuilder.parameters,
            encoding: parametersBuilder.parameterEncoding,
            headers: headers ?? nil
        )
        .validate()
        .responseJSON { response in
            self.handleResponse(response, completion: completion)
        }
    }

    // MARK: - Build Parameters for  Requests

    private func buildParameters(withTask task: Task) -> (parameters: [String: Any]?,
                                                          parameterEncoding: ParameterEncoding,
                                                          multiPartData: [MultiPartData]?)
    {
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
