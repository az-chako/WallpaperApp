//
//  UnsplashImage.swift
//  WallpaperApp
//
//  Created by spark-03 on 2024/07/01.
//
import Foundation

struct UnsplashImage: Codable {
    let id: String
    let urls: ImageURLs
    let user: User
    let updatedAt: String
    let alternativeSlugs: AlternativeSlugs?

    enum CodingKeys: String, CodingKey {
        case id
        case urls
        case user
        case updatedAt = "updated_at"
        case alternativeSlugs = "alternative_slugs"
    }
}

struct ImageURLs: Codable {
    let regular: String
}

struct User: Codable {
    let name: String
    let username: String
    let location: String?
}

struct AlternativeSlugs: Codable {
    let ja: String?
}
