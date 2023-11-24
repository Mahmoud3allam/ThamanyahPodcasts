//
//  PlayListResponse.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 24/11/2023.
//

import Foundation

struct PlayListResponse: Codable {
    let data: PlayListDetails?
}

struct PlayListDetails: Codable {
    let playlist: Playlist?
    let episodes: [Episode]?
}

struct Episode: Codable {
    let id, itunesID: String?
    let type: Int?
    let name, description: String?
    let image, imageBigger: String?
    let audioLink: String?
    let duration, durationInSeconds, views: Int?
    let podcastItunesID, podcastName, releaseDate, createdAt: String?
    let updatedAt: String?
    let isDeleted: Bool?
    let isEditorPick, sentNotification: Bool?
    let position: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case itunesID = "itunesId"
        case type, name, description, image, imageBigger, audioLink, duration, durationInSeconds, views
        case podcastItunesID = "podcastItunesId"
        case podcastName, releaseDate, createdAt, updatedAt, isDeleted, isEditorPick, sentNotification, position
    }
}

// MARK: - Playlist

struct Playlist: Codable {
    let id: String?
    let type: Int?
    let name, description: String?
    let image: String?
    let access, status: String?
    let episodeCount, episodeTotalDuration: Int?
    let createdAt, updatedAt: String?
    let isDeleted: Bool?
    let followingCount: Int?
    let userID: String?
    let isSubscribed: Bool?

    enum CodingKeys: String, CodingKey {
        case id, type, name, description, image, access, status, episodeCount, episodeTotalDuration, createdAt, updatedAt, isDeleted, followingCount
        case userID = "userId"
        case isSubscribed
    }
}
