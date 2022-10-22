//
//  MADetailsLabel.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 22.10.2022.
//

import UIKit

class MADetailsLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: .zero)
        configure()
    }

    private func configure() {
        textColor = .systemBackground
        textAlignment = .left
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
