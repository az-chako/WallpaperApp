//
//  UnsplashService.swift
//  WallpaperApp
//
//  Created by spark-03 on 2024/07/04.
//

import Foundation

struct UnsplashService {
    private let accessKey = "2t1vdj2pJ7IJmMz_1os77S5M5SlnjKvCpIn8yHg0vlI"
    
    func fetchImages(forColor color: String, completion: @escaping (Result<[UnsplashImage], Error>) -> Void) {
        let urlString = "https://api.unsplash.com/search/photos/?per_page=5&order_by=latest&query=color=\(color)&client_id=\(accessKey)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let searchResult = try decoder.decode(SearchResult.self, from: data)
                completion(.success(searchResult.results))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

// SearchResult構造体をここに移動
struct SearchResult: Codable {
    let results: [UnsplashImage]
}
