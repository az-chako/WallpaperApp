//
//  UnsplashImage.swift
//  WallpaperApp
//
//  Created by spark-03 on 2024/07/01.
//

import Foundation

struct UnsplashImage: Decodable {
    let id: String
    let urls: ImageURLs
    let user: User
    let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case urls
        case user
        case updatedAt = "updated_at"
    }
}

struct ImageURLs: Decodable {
    let regular: String
}

struct User: Decodable {
    let name: String
}
