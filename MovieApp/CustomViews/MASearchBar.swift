//
//  MASearchBar.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 19.10.2022.
//

import UIKit

class MASearchBar: UISearchBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        // custom code
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)
        backgroundColor = backgroundColor
        searchBarStyle = UISearchBar.Style.default
        placeholder = " Search..."
        sizeToFit()
        isTranslucent = false
        backgroundImage = UIImage()
        configure()
    }

    private func configure() {
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
    }
}
