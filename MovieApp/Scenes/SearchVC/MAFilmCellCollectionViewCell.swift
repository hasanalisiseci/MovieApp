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
    let movieTitleLabel = MATitleLabel(textAlignment: .left, fontSize: 16, color: .systemBackground)
    let yearTitleLabel = MACellPropertyLabel(textAlignment: .left)
    let movieOrSeriesLabel = MACellPropertyLabel(textAlignment: .left)
    let movieIcon = MAIconView(frame: .zero)
    let yearIcon = MAIconView(frame: .zero)

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
        movieIcon.configure(iconName: "video-camera")
        yearIcon.configure(iconName: "calendar")
    }

    private func configure() {
        addSubview(moviePosterImage)
        addSubview(movieTitleLabel)
        addSubview(yearTitleLabel)
        addSubview(movieOrSeriesLabel)
        addSubview(movieIcon)
        addSubview(yearIcon)

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

            yearIcon.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 12),
            yearIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -24),
            yearIcon.trailingAnchor.constraint(equalTo: yearTitleLabel.leadingAnchor, constant: 20),
            yearIcon.heightAnchor.constraint(equalToConstant: 20),

            yearTitleLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 12),
            yearTitleLabel.leadingAnchor.constraint(equalTo: yearIcon.trailingAnchor, constant: padding),
            yearTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            yearTitleLabel.heightAnchor.constraint(equalToConstant: 20),

            movieIcon.topAnchor.constraint(equalTo: yearIcon.bottomAnchor, constant: 6),
            movieIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -24),
            movieIcon.trailingAnchor.constraint(equalTo: movieOrSeriesLabel.leadingAnchor, constant: 20),
            movieIcon.heightAnchor.constraint(equalToConstant: 20),

            movieOrSeriesLabel.topAnchor.constraint(equalTo: yearTitleLabel.bottomAnchor, constant: 6),
            movieOrSeriesLabel.leadingAnchor.constraint(equalTo: movieIcon.trailingAnchor, constant: padding),
            movieOrSeriesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            movieOrSeriesLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
