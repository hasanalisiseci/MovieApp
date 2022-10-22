//
//  Color+Extension.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 22.10.2022.
//

import UIKit

enum AssetsColor {
    case collectionViewBG
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
        switch name {
        case .collectionViewBG:
            return UIColor(named: "BackgroundPurple")
        }
    }
}
