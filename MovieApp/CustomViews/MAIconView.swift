//
//  MAIconView.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 20.10.2022.
//

import UIKit

class MAIconView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(iconName: String) {
        layer.cornerRadius = 12
        contentMode = .scaleAspectFit
        clipsToBounds = true
        image = UIImage(named: iconName)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
