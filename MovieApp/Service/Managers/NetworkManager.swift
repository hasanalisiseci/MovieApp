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

    func getData<T: Codable>(endpoint: OMDbEndpoint, completed: @escaping (Result<T, MAErrorType>) -> Void) {
        guard let url = URL(string: endpoint.url) else {
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
                let result = try decoder.decode(T.self, from: data)
                completed(.success(result))
            } catch {
                let error = self.errorHandling(data: data)
                completed(.failure(.decodingError(model: error)))
            }
        }

        task.resume()
    }

    func errorHandling(data: Data?) -> ErrorModel {
        let decoder = JSONDecoder()

        guard let data = data else {
            return ErrorModel(response: "Error", error: "No Data")
        }

        guard let result = try? decoder.decode(ErrorModel.self, from: data) else { return ErrorModel(response: "Error", error: "Decode Error") }
        return result
    }
}

struct ErrorModel: Codable, Error {
    let response, error: String?

    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case error = "Error"
    }
}
