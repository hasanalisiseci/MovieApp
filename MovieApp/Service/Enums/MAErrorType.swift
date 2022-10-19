//
//  MAErrorType.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 18.10.2022.
//

import Foundation

enum MAErrorType: Error {
    case decodingError(model: ErrorModel)
    case unableToComplete
    case invalidURL
    case invalidResponse
    case invalidData
    case noMoreMovie

    var message: String {
        switch self {
        case let .decodingError(model):
            return model.localizedDescription
        case .unableToComplete:
            return "Check your internet connection."
        case .invalidURL:
            return "Url error"
        case .invalidResponse:
            return "Response Error"
        case .invalidData:
            return "Data error"
        case .noMoreMovie:
            return "We can't find more movie. Please research with new keyword."
        }
    }
}
