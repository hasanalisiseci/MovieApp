//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 18.10.2022.
//

import Foundation
import UIKit

class NetworkManager {
    let cache = NSCache<NSString, UIImage>()

    func getData<T: Decodable>(endpoint: URL, completed: @escaping (Result<T, MAErrorType>) -> Void) {
        guard let url = URL(string: endpoint.absoluteString) else {
            completed(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completed(.failure(.unableToComplete))
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(T.self, from: data)
                completed(.success(result))
            } catch {
                let error = self.errorHandling(data: data)
                completed(.failure(.decodingError(model: error)))
            }
        }

        task.resume()
    }

    func errorHandling(data: Data?) -> APIErrorModel {
        let decoder = JSONDecoder()

        guard let data = data else {
            return APIErrorModel(response: "Error", error: "No Data")
        }

        guard let decodedResponse = try? decoder.decode(APIErrorModel.self, from: data) else { return APIErrorModel(response: "Error", error: "Decode Error") }

        return decodedResponse
    }
}

struct APIErrorModel: Codable, Error {
    let response, error: String?

    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case error = "Error"
    }
}

/* NetworkManager().getMovies(endpoint: OMDbEndpoint.search(String(describing: movieSearchBar.text!.utf8), 1).url) { [weak self] (result: Result<MovieResult, MAErrorType>) in
      guard let self = self else { return }
     switch result {
     case let .success(success):
         print(success)
     case let .failure(failure):
         print(failure)
     }
 }
  NetworkManager().getMovies(endpoint: OMDbEndpoint.detail("tt0096895", "full").url) { [weak self] (result: Result<MovieDetail, MAErrorType>) in
      guard let self = self else { return }
     switch result {
     case let .success(success):
         print(success)
     case let .failure(failure):
         print(failure)
     }
 }
 */
