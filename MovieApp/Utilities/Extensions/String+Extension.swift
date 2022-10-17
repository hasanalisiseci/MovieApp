//
//  String+Extension.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 17.10.2022.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self)
    }
}
