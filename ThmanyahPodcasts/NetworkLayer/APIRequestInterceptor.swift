//
//  APIRequestInterceptor.swift
//  ThmanyahPodcasts
//
//  Created Arab Calibers on 23/11/2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
// @Mahmoud Allam Templete ^_^
import Alamofire
import Foundation

final class APIRequestInterceptor: RequestInterceptor {
    func adapt(_: URLRequest, for _: Session, completion _: @escaping (Result<URLRequest, Error>) -> Void) {}

    func retry(_: Request, for _: Session, dueTo _: Error, completion _: @escaping (RetryResult) -> Void) {}
}
