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

    let scrollView = UIScrollView()
    let contentView = UIView()
    let backButton = UIButton(type: .system)

    var detailPosterImage = MADetailImageView(frame: .zero)
    var movieTitleLabel = MATitleLabel(textAlignment: .left, fontSize: 40, color: .systemBackground)
    var runtimeIconView = MAIconView(frame: .zero)
    var movieRuntimeLabel = MADetailsLabel()
    var rateIconView = MAIconView(frame: .zero)
    var movieImdbRateLabel = MADetailsLabel()
    var movieReleaseDateTitleLabel = MATitleLabel(textAlignment: .left, fontSize: 18, color: .systemBackground)
    var movieReleaseDateLabel = MADetailsLabel()
    var movieGenreTitleLabel = MATitleLabel(textAlignment: .left, fontSize: 18, color: .systemBackground)
    var movieGenreLabel = MADetailsLabel()
    var movieDirectorTitleLabel = MATitleLabel(textAlignment: .left, fontSize: 18, color: .systemBackground)
    var movieDirectorLabel = MADetailsLabel()
    var movieWritersTitleLabel = MATitleLabel(textAlignment: .left, fontSize: 18, color: .systemBackground)
    var movieWritersLabel = MADetailsLabel()
    var movieActorsTitleLabel = MATitleLabel(textAlignment: .left, fontSize: 18, color: .systemBackground)
    var movieActorsLabel = MADetailsLabel()
    var movieSynopsisTitleLabel = MATitleLabel(textAlignment: .left, fontSize: 18, color: .systemBackground)
    var movieSynopsisLabel = MADetailsLabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appColor(.collectionViewBG)
        getMovieDetails()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLayoutSubviews() {
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 150)
    }

    func getMovieDetails() {
        NetworkManager().getData(endpoint: OMDbEndpoint.detail(movie.imdbID!, "short")) { [weak self] (result: Result<MovieDetail, MAErrorType>) in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.detailedMovie = data
                DispatchQueue.main.async {
                    self.set()
                    FirebaseManager.shared.logFilmDetails(title: "\(self.detailedMovie.title!)", detail: "\(self.detailedMovie.title!) is directed by \(self.detailedMovie.director!)")
                }
            case let .failure(failure):
                print(failure)
            }
        }
    }

    private func set() {
        detailPosterImage.downloadImage(from: detailedMovie.poster!)
        movieTitleLabel.text = detailedMovie.title
        runtimeIconView.configure(iconName: "clock")
        movieRuntimeLabel.text = detailedMovie.runtime
        rateIconView.configure(iconName: "star")
        movieImdbRateLabel.text = "\(detailedMovie.imdbRating!) (IMDb)"
        movieReleaseDateTitleLabel.text = Constants.release_date_title
        movieReleaseDateLabel.text = detailedMovie.released
        movieGenreTitleLabel.text = Constants.genre_title
        movieGenreLabel.text = detailedMovie.genre
        movieDirectorTitleLabel.text = Constants.director_title
        movieDirectorLabel.text = detailedMovie.director
        movieWritersTitleLabel.text = Constants.writer_title
        movieWritersLabel.text = detailedMovie.writer
        movieActorsTitleLabel.text = Constants.actors_title
        movieActorsLabel.text = detailedMovie.actors
        movieSynopsisTitleLabel.text = Constants.synopsis_title
        movieSynopsisLabel.text = detailedMovie.plot
    }

    @objc func backAction(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    private func configureUI() {
        configureButton()
        configureScrollView()
        contentView.addSubview(detailPosterImage)
        contentView.addSubview(backButton)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(runtimeIconView)
        contentView.addSubview(movieRuntimeLabel)
        contentView.addSubview(rateIconView)
        contentView.addSubview(movieImdbRateLabel)
        contentView.addSubview(movieReleaseDateTitleLabel)
        contentView.addSubview(movieReleaseDateLabel)
        contentView.addSubview(movieGenreTitleLabel)
        contentView.addSubview(movieGenreLabel)
        contentView.addSubview(movieDirectorTitleLabel)
        contentView.addSubview(movieDirectorLabel)
        contentView.addSubview(movieWritersTitleLabel)
        contentView.addSubview(movieWritersLabel)
        contentView.addSubview(movieActorsTitleLabel)
        contentView.addSubview(movieActorsLabel)
        contentView.addSubview(movieSynopsisTitleLabel)
        contentView.addSubview(movieSynopsisLabel)

        let bigPadding: CGFloat = 20
        let padding: CGFloat = 10
        let hPadding: CGFloat = 45
        let bigheight: CGFloat = 50
        let smallHeight: CGFloat = 24

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: padding),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            backButton.heightAnchor.constraint(equalToConstant: 25),
            backButton.widthAnchor.constraint(equalToConstant: 25),

            detailPosterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            detailPosterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            detailPosterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            detailPosterImage.heightAnchor.constraint(equalToConstant: 350),

            movieTitleLabel.topAnchor.constraint(equalTo: detailPosterImage.bottomAnchor, constant: bigPadding),
            movieTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: bigheight),

            runtimeIconView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: padding),
            runtimeIconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -bigPadding),
            runtimeIconView.trailingAnchor.constraint(equalTo: movieRuntimeLabel.leadingAnchor, constant: 25),
            runtimeIconView.heightAnchor.constraint(equalToConstant: smallHeight),

            movieRuntimeLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: padding),
            movieRuntimeLabel.leadingAnchor.constraint(equalTo: runtimeIconView.trailingAnchor, constant: 0),
            movieRuntimeLabel.trailingAnchor.constraint(equalTo: rateIconView.leadingAnchor, constant: -bigPadding),
            movieRuntimeLabel.heightAnchor.constraint(equalToConstant: smallHeight),

            rateIconView.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: padding),
            rateIconView.leadingAnchor.constraint(equalTo: movieRuntimeLabel.trailingAnchor, constant: bigPadding),
            rateIconView.trailingAnchor.constraint(equalTo: movieImdbRateLabel.leadingAnchor, constant: 0),
            rateIconView.heightAnchor.constraint(equalToConstant: smallHeight),

            movieImdbRateLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: padding),
            movieImdbRateLabel.leadingAnchor.constraint(equalTo: rateIconView.trailingAnchor, constant: -bigPadding),
            movieImdbRateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.3),
            movieImdbRateLabel.heightAnchor.constraint(equalToConstant: smallHeight),

            movieReleaseDateTitleLabel.topAnchor.constraint(equalTo: runtimeIconView.bottomAnchor, constant: bigPadding),
            movieReleaseDateTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieReleaseDateTitleLabel.trailingAnchor.constraint(equalTo: movieGenreTitleLabel.leadingAnchor, constant: -bigPadding),
            movieReleaseDateTitleLabel.heightAnchor.constraint(equalToConstant: smallHeight),
            movieReleaseDateTitleLabel.widthAnchor.constraint(equalToConstant: 100),

            movieGenreTitleLabel.topAnchor.constraint(equalTo: runtimeIconView.bottomAnchor, constant: bigPadding),
            movieGenreTitleLabel.leadingAnchor.constraint(equalTo: movieReleaseDateTitleLabel.trailingAnchor, constant: -bigPadding),
            movieGenreTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieGenreTitleLabel.heightAnchor.constraint(equalToConstant: smallHeight),
            movieGenreTitleLabel.widthAnchor.constraint(equalToConstant: 100),

            movieReleaseDateLabel.topAnchor.constraint(equalTo: movieReleaseDateTitleLabel.bottomAnchor, constant: padding),
            movieReleaseDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieReleaseDateLabel.trailingAnchor.constraint(equalTo: movieGenreLabel.leadingAnchor, constant: -bigPadding),
            movieReleaseDateLabel.heightAnchor.constraint(equalToConstant: smallHeight),

            movieGenreLabel.topAnchor.constraint(equalTo: movieReleaseDateTitleLabel.bottomAnchor, constant: padding),
            movieGenreLabel.leadingAnchor.constraint(equalTo: movieReleaseDateLabel.trailingAnchor, constant: bigPadding),
            movieGenreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieGenreLabel.heightAnchor.constraint(equalToConstant: smallHeight),

            movieDirectorTitleLabel.topAnchor.constraint(equalTo: movieReleaseDateLabel.bottomAnchor, constant: bigPadding),
            movieDirectorTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieDirectorTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieDirectorTitleLabel.heightAnchor.constraint(equalToConstant: smallHeight),

            movieDirectorLabel.topAnchor.constraint(equalTo: movieDirectorTitleLabel.bottomAnchor, constant: padding),
            movieDirectorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieDirectorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieDirectorLabel.heightAnchor.constraint(equalToConstant: smallHeight),

            movieWritersTitleLabel.topAnchor.constraint(equalTo: movieDirectorLabel.bottomAnchor, constant: bigPadding),
            movieWritersTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieWritersTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieWritersTitleLabel.heightAnchor.constraint(equalToConstant: smallHeight),

            movieWritersLabel.topAnchor.constraint(equalTo: movieWritersTitleLabel.bottomAnchor, constant: padding),
            movieWritersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieWritersLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieWritersLabel.heightAnchor.constraint(equalToConstant: smallHeight),

            movieActorsTitleLabel.topAnchor.constraint(equalTo: movieWritersLabel.bottomAnchor, constant: bigPadding),
            movieActorsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieActorsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieActorsTitleLabel.heightAnchor.constraint(equalToConstant: smallHeight),

            movieActorsLabel.topAnchor.constraint(equalTo: movieActorsTitleLabel.bottomAnchor, constant: padding),
            movieActorsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieActorsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieActorsLabel.heightAnchor.constraint(equalToConstant: smallHeight),

            movieSynopsisTitleLabel.topAnchor.constraint(equalTo: movieActorsLabel.bottomAnchor, constant: bigPadding),
            movieSynopsisTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieSynopsisTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieSynopsisTitleLabel.heightAnchor.constraint(equalToConstant: smallHeight),

            movieSynopsisLabel.topAnchor.constraint(equalTo: movieSynopsisTitleLabel.bottomAnchor, constant: padding),
            movieSynopsisLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieSynopsisLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieSynopsisLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: padding),
        ])
    }

    private func configureButton() {
        backButton.frame = CGRect()
        backButton.setImage(UIImage(named: "previous"), for: .normal)
        backButton.tintColor = .systemBackground
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.isUserInteractionEnabled = true
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }

    private func configureScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
}
