//
//  DetailVC.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 20.10.2022.
//

import UIKit

class DetailVC: UIViewController {
    var movie: Movie!
    var detailedMovie: MovieDetail!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        getMovieDetails()
    }


    func getMovieDetails() {
        NetworkManager().getData(endpoint: OMDbEndpoint.detail(movie.imdbID!, "full")) { [weak self] (result: Result<MovieDetail, MAErrorType>) in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.detailedMovie = data
                print(self.detailedMovie)
            case let .failure(failure):
                print(failure)
            }
        }
    }
}
