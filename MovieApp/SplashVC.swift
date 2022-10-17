//
//  SplashVC.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 17.10.2022.
//

import FirebaseRemoteConfig
import UIKit

class SplashVC: UIViewController {
    private var splashTitleLabel = MATitleLabel(textAlignment: .center, fontSize: 40)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    override func viewDidAppear(_ animated: Bool) {
        if NetworkMonitor.shared.isConnected {
            configureTitleLabel()
            FirebaseManager.shared.fetchRCValues { result in
                switch result {
                case let .success(success):
                    DispatchQueue.main.async {
                        self.splashTitleLabel.text = success
                    }
                case let .failure(error):
                    self.showAlert(alertText: "Fetch Problem", alertMessage: error.localizedDescription)
                }
            }

        } else {
            showAlert(alertText: "Network Problem", alertMessage: "Check your internet connect.")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func configureTitleLabel() {
        view.addSubview(splashTitleLabel)
        splashTitleLabel.text = ""

        let padding: CGFloat = 50
        let topDistance: CGFloat = view.bounds.height / 2
        let labelHeight: CGFloat = 30

        NSLayoutConstraint.activate([
            splashTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: topDistance),
            splashTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            splashTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            splashTitleLabel.heightAnchor.constraint(equalToConstant: labelHeight),
        ])
    }
}
