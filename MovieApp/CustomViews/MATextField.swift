//
//  MATextField.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 17.10.2022.
//

import UIKit

class MATextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false // Görünümün otomatik yeniden boyutlandırma maskesinin Otomatik Mizanpaj kısıtlamalarına dönüştürülüp çevrilmeyeceğini belirleyen bir Boole değeri.
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor

        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        minimumFontSize = 12
        adjustsFontSizeToFitWidth = true // Etiketin, başlık dizesini etiketin sınırlayıcı dikdörtgenine sığdırmak için metnin yazı tipi boyutunu küçültüp küçültmediğini belirleyen bir Boole değeri.
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no // Metin nesnesi için otomatik düzeltme stili.
        placeholder = Constants.search_movie_name
        autocapitalizationType = .none
        returnKeyType = .go
    }
}
