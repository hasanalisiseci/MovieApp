//
//  SearchVC.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 17.10.2022.
//

import UIKit

class SearchVC: UIViewController, UITextFieldDelegate {
    let movieSearchBar = MATextField()
    let searchToMovieButton = MAButton(backgroundColor: .systemBlue, title: Constants.search)

    var isUsernameEntered: Bool { return !movieSearchBar.text!.isEmpty }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        configureSearchBar()
        configureButton()
        createDissmisKeyboardTapGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configuerNavBar()
    }

    private func configuerNavBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.title = "MovieApp"
    }

    private func configureSearchBar() {
        view.addSubview(movieSearchBar)
        movieSearchBar.delegate = self

        NSLayoutConstraint.activate([
            movieSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            movieSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            movieSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            movieSearchBar.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    private func configureButton() {
        view.addSubview(searchToMovieButton)
        searchToMovieButton.addTarget(self, action: #selector(searchMovie), for: .touchUpInside)

        NSLayoutConstraint.activate([
            searchToMovieButton.topAnchor.constraint(equalTo: movieSearchBar.bottomAnchor, constant: 50),
            searchToMovieButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchToMovieButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchToMovieButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    @objc func searchMovie() {
    }

    func createDissmisKeyboardTapGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
}

extension SearchVC: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
