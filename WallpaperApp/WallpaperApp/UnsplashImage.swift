//
//  UnsplashImage.swift
//  WallpaperApp
//
//  Created by spark-03 on 2024/06/25.
//

import Foundation

struct UnsplashImage: Codable {
    let id: String
    let urls: URLS
    let user: User
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case urls
        case user
        case updatedAt = "updated_at"
    }
}

struct URLS: Codable {
    let regular: String
}

struct User: Codable {
    let name: String
}
