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
    private let remoteConfig = RemoteConfig.remoteConfig()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        configureTitleLabel()
        fetchRCValues()
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

    private func fetchRCValues() {
        let defaults: [String: NSObject] = ["splash_title_label_text": "deneme" as NSObject]
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings

        remoteConfig.fetch(withExpirationDuration: 0) { status, error in
            if status == .success, error == nil {
                self.remoteConfig.activate { _, error in
                    guard error == nil else {
                        return
                    }

                    let value = self.remoteConfig.configValue(forKey: "splash_title_label_text").stringValue
                    DispatchQueue.main.async {
                        self.splashTitleLabel.text = value
                    }
                }

            } else {
                print("something went wrong")
            }
        }
    }
}
