//
//  MACellPropertyLabel.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 19.10.2022.
//

import UIKit

class MACellPropertyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        configure()
    }

    private func configure() {
        textColor = .systemBackground
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
