//
//  SearchVC.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 17.10.2022.
//

import UIKit

class SearchVC: UIViewController {
    lazy var searchBar: UISearchBar = MASearchBar()
    var isSearch: Bool = false

    enum Section { case main }

    var movies: [Movie] = []
    var page = 1
    var hasMoreMovie = true

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        allConfigure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configuerNavBar()
        configureSearchBar()
    }

    func allConfigure() {
        hideKeyboardWhenTappedAround()
        configureCollectionView()
        configureDataSource()
    }

    private func configuerNavBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.setHidesBackButton(true, animated: true)
    }

    private func configureSearchBar() {
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
}

extension SearchVC {
    func getMovies(movieTitle: String, page: Int) {
        NetworkManager().getData(endpoint: OMDbEndpoint.search(movieTitle, page)) { [weak self] (result: Result<MoviesResult, MAErrorType>) in
            guard let self = self else { return }
            switch result {
            case let .success(result):
                DispatchQueue.main.async {
                    if result.movies == nil {
                        self.stopIndicator()
                        if self.movies.isEmpty {
                            self.showAlert(alertText: Constants.alert_title, alertMessage: Constants.movie_not_found_description)
                        } else {
                            self.showAlert(alertText: Constants.alert_title, alertMessage: Constants.no_more_movie_description)
                        }

                    } else {
                        self.stopIndicator()
                        self.movies.append(contentsOf: result.movies!)
                        self.updateData()
                    }
                }
            case let .failure(failure):
                self.showAlert(alertText: Constants.alert_title, alertMessage: failure.message)
            }
        }
    }

    func startIndicator() {
        let container: UIView = UIView()
        container.frame = view.frame
        container.center = view.center
        container.backgroundColor = .clear

        let loadingView: UIView = UIView()
        loadingView.frame = CGRectMake(0, 0, 118, 80)
        loadingView.center = view.center
        loadingView.backgroundColor = .gray
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10

        activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRectMake(40, 12, 40, 40)
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        loadingView.addSubview(activityIndicator)

        let label = UILabel(frame: CGRectMake(5, 55, 120, 20))
        label.text = Constants.loading_title
        label.textColor = UIColor.white
        label.bounds = CGRectMake(0, 0, loadingView.frame.size.width / 2, loadingView.frame.size.height / 2)
        label.font = UIFont.systemFont(ofSize: 12)
        loadingView.addSubview(label)
        container.addSubview(loadingView)
        view.addSubview(container)

        activityIndicator.startAnimating()
    }

    func stopIndicator() {
        DispatchQueue.main.async {
            UIApplication.shared.endIgnoringInteractionEvents()
            self.activityIndicator.stopAnimating()
        }
        ((activityIndicator.superview as UIView?)?.superview as UIView?)?.removeFromSuperview()
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            configureDataSource()
            collectionView.setHaventSearch(Constants.havent_searched_yet)
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text?.count == 0 {
            showAlert(alertText: Constants.blank_search_alert_title, alertMessage: Constants.please_enter_movie_name)
        } else {
            collectionView.restore()
            startIndicator()
            movies = []
            page = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.getMovies(movieTitle: searchBar.text!, page: self.page)
            })
        }
    }
}

extension SearchVC: UICollectionViewDelegate {
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .appColor(.collectionViewBG)
        collectionView.register(MAFilmCellCollectionViewCell.self, forCellWithReuseIdentifier: MAFilmCellCollectionViewCell.reuseID)
        collectionView.setHaventSearch(Constants.havent_searched_yet)
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Movie>(collectionView: collectionView) { collectionView, indexPath, movie -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MAFilmCellCollectionViewCell.reuseID, for: indexPath) as! MAFilmCellCollectionViewCell
            cell.set(movie: movie)
            return cell
        }
    }

    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let ofssetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if ofssetY > contentHeight - height {
            guard hasMoreMovie else { return }
            page += 1

            startIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [self] in
                self.getMovies(movieTitle: searchBar.text!, page: self.page)
            })
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = DetailVC()
        destVC.movie = movies[indexPath.item]
        navigationController?.show(destVC, sender: nil)
    }
}

extension UICollectionView {
    func setHaventSearch(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 28)
        messageLabel.sizeToFit()

        backgroundView = messageLabel
    }

    func restore() {
        backgroundView = nil
    }
}
