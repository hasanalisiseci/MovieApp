//
//  OMDbEndpoint.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 18.10.2022.
//

import Foundation

enum OMDbEndpoint {
    private var baseURL: String { return "https://www.omdbapi.com/?" }
    private var apiKey: String { return "apiKey=3e9f07f2" }
    private var searchParameter: String { return "&s=" }
    private var pageParameter: String { return "&page=" }
    private var imdbIdParameter: String { return "&i=" }
    private var plotParameter: String { return "&plot=" }

    case search(String, Int)
    case detail(String, String)

    private var fullPath: String {
        var endpoint: String
        switch self {
        case let .search(searchValue, pageValue):
            let mutableString = NSMutableString(string: searchValue) as CFMutableString
            CFStringTransform(mutableString, nil, kCFStringTransformStripCombiningMarks, Bool(truncating: 0))
            var movie = (mutableString as NSMutableString).copy() as! NSString
            movie = movie.trimmingCharacters(in: .whitespaces) as NSString
            movie = movie.replacingOccurrences(of: " ", with: "+") as NSString
            endpoint = "\(searchParameter)\(movie)\(pageParameter)\(pageValue.toStr())"
        case let .detail(imdbValue, plotValue):
            endpoint = "\(imdbIdParameter)\(imdbValue)\(plotParameter)\(plotValue)"
        }
        return baseURL + apiKey + endpoint
    }

    var url: String {
        fullPath
    }
}

enum PlotEnum: String {
    case full
    case short
}
