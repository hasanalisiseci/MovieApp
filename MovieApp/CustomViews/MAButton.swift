//
//  MAButton.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 17.10.2022.
//

import UIKit

class MAButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        // custom code
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        configure()
    }

    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
