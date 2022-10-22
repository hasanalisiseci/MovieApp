//
//  MATextView.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 22.10.2022.
//

import UIKit

class MATextView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        textColor = .systemBackground
    }
}
