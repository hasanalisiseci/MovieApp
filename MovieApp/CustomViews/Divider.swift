//
//  Divider.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 22.10.2022.
//

import UIKit

class Divider: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .white
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.white.cgColor
    }

}
