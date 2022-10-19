//
//  SearchVC.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 17.10.2022.
//

import UIKit

class SearchVC: UIViewController, UISearchBarDelegate {
    lazy var searchBar: UISearchBar = MASearchBar()
    var isSearch: Bool = false

    enum Section { case main }

    var movies: [Movie] = []
    var page = 1
    var hasMoreMovie = true

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        hideKeyboardWhenTappedAround()
        configureSearchBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configuerNavBar()
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

    func createDissmisKeyboardTapGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(dismissKeyboardTap)
    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemPink
        collectionView.register(MAFilmCellCollectionViewCell.self, forCellWithReuseIdentifier: MAFilmCellCollectionViewCell.reuseID)
    }

    func getMovies(movieTitle: String, page: Int) {
        NetworkManager().getData(endpoint: OMDbEndpoint.search(movieTitle, page).url) { [weak self] (result: Result<MoviesResult, MAErrorType>) in
            guard let self = self else { return }
            switch result {
            case let .success(result):
                if result.movies == nil {
                    self.showAlert(alertText: "HATA", alertMessage: "Aradığınız film bulunamadı!")
                } else {
                    self.movies.append(contentsOf: result.movies!)
                    self.updateData()
                }
            case let .failure(failure):
                self.showAlert(alertText: "HATA", alertMessage: failure.message)
            }
        }
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
}

extension SearchVC {
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.resignFirstResponder()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text?.count == 0 {
            showAlert(alertText: "Boş Arama Yapılamaz", alertMessage: "Lütfen film adı girin!")
        } else {
            movies = []
            page = 1
            getMovies(movieTitle: String(describing: searchBar.text!.utf8), page: page)
        }
    }
}

extension SearchVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let ofssetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if ofssetY > contentHeight - height {
            guard hasMoreMovie else { return }
            page += 1
            getMovies(movieTitle: String(describing: searchBar.text!.utf8), page: page)
        }
    }
}
