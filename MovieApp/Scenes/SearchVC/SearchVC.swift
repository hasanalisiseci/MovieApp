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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        hideKeyboardWhenTappedAround()
        configureSearchBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configuerNavBar()
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
            NetworkManager().getData(endpoint: OMDbEndpoint.search(String(describing: searchBar.text!.utf8), 1).url) { [weak self] (result: Result<MoviesResult, MAErrorType>) in
                guard let self = self else { return }
                switch result {
                case let .success(success):
                    if success.movies == nil {
                        self.showAlert(alertText: "HATA", alertMessage: "Aradığınız film bulunamadı!")
                    } else {
                        print(success)
                    }
                case let .failure(failure):
                    self.showAlert(alertText: "HATA", alertMessage: failure.localizedDescription)
                }
            }
        }
    }
}
