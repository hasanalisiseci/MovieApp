//
//  UIViewController+Extension.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 17.10.2022.
//

import UIKit

extension UIViewController {
    func showAlert(alertText: String, alertMessage: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: Constants.okay, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
