//
//  UserResponse.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 23/11/2023.
//

import Foundation

// MARK: - User

struct UserResponse: Codable {
    let accessToken, refreshToken: String?
    let expiresIn: Int?
}
