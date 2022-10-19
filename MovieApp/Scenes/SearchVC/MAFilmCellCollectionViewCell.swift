//
//  MAFilmCellCollectionViewCell.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 19.10.2022.
//

import UIKit

class MAFilmCellCollectionViewCell: UICollectionViewCell {
    static let reuseID = "MovieCell"

    let moviePosterImage = MAImageView(frame: .zero)
    let movieTitleLabel = MATitleLabel(textAlignment: .center, fontSize: 16, color: .systemBackground)
    let yearTitleLabel = MACellPropertyLabel()
    let movieOrSeriesLabel = MACellPropertyLabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray.withAlphaComponent(0.5)
        layer.cornerRadius = 12
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(movie: Movie) {
        movieTitleLabel.text = movie.title
        yearTitleLabel.text = movie.year
        movieOrSeriesLabel.text = movie.type?.rawValue
        moviePosterImage.downloadImage(from: movie.poster!)
    }

    private func configure() {
        addSubview(moviePosterImage)
        addSubview(movieTitleLabel)
        addSubview(yearTitleLabel)
        addSubview(movieOrSeriesLabel)

        let padding: CGFloat = 8
        let inPadding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10

        NSLayoutConstraint.activate([
            moviePosterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            moviePosterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            moviePosterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            moviePosterImage.widthAnchor.constraint(equalToConstant: contentView.bounds.width - inPadding - minimumItemSpacing),
            moviePosterImage.heightAnchor.constraint(equalTo: moviePosterImage.widthAnchor),

            movieTitleLabel.topAnchor.constraint(equalTo: moviePosterImage.bottomAnchor, constant: 12),
            movieTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 20),

            yearTitleLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 12),
            yearTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            yearTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            yearTitleLabel.heightAnchor.constraint(equalToConstant: 20),

            movieOrSeriesLabel.topAnchor.constraint(equalTo: yearTitleLabel.bottomAnchor, constant: 12),
            movieOrSeriesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieOrSeriesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieOrSeriesLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
