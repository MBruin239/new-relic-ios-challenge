//
//  CatFetcher.swift
//  NewRelic
//
//  Created by newrelic on 8/16/20.
//  Copyright © 2020 newrelic. All rights reserved.
//

import Foundation

class CatFetcher: NSObject {
    
    static let shared = CatFetcher()
    var urlSession: URLSession?

    private override init() {
        super.init()
        self.urlSession = URLSession(configuration: URLSessionConfiguration.default)
    }
    private func buildCatFactRequest(perPage: Int, page: Int) -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "catfact.ninja"
        components.path = "/breeds"
        components.queryItems = [
            URLQueryItem(name: "limit", value: "\(perPage)"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        let url = components.url!
        let request = URLRequest(url: url)
        return request
    }
    /// Fetches the list of CatDetails.
    ///
    /// - Parameters:
    ///   - perPage:  How many results per page
    ///   - page:     The page of the partial results
    ///   - queue:    The `DispatchQueue` on which the `callback` is called. Default is
    ///               `DispatchQueue.main`.
    ///   - callback: The callback that will be invoked with the list of places or an empty Array in
    ///               case of an error.
    func loadCats(perPage: Int, page: Int, queue: DispatchQueue = .main, callback: @escaping (Result<[CatDetail], Error>, (URL?)) -> Void) {
        
        let request = buildCatFactRequest(perPage: perPage, page: page)
        
        let task = urlSession?.dataTask(with: request) { data, response, err in
            guard err == nil else {
                queue.async {
                    callback(.failure(err!), response?.url)
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(CatResult.self, from: data!)
                queue.async {
                    callback(.success(result.data), response?.url)
                }
            } catch {
                queue.async {
                    callback(.failure(err!), response?.url)
                }
            }
        }
        
        task?.resume()
    }
}

