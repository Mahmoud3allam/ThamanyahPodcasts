//
//  UserResponse.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 23/11/2023.
//

import Foundation

// MARK: - User

struct UserResponse: Codable {
    let accessToken, refreshToken: String?
    let expiresIn: Int?
}
