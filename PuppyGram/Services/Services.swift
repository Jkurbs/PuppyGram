//
//  Services.swift
//  PuppyGram
//
//  Created by Kerby Jean on 5/11/21.
//

import Foundation


class Services {
    
    // MARK: - Properties
    static var shared = Services()
    private let url = "https://api.flickr.com/services/feeds/photos_public.gne?tags=puppy&format=json&nojsoncallback=10"
    
    enum NetworkError: Error {
        case badURL
        case noData
        case decodingError
    }
    
    // MARK: - Functions
    func fetchData(completionHandler: @escaping (_ result: Result<[Item], NetworkError>) -> Void) {
        guard let url =  URL(string: url) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            do {
                let puppy = try JSONDecoder().decode(Puppy.self, from: data)
                completionHandler(.success(puppy.items))
            } catch {
                completionHandler(.failure(error as! Services.NetworkError))
            }
        }.resume()
    }
}
