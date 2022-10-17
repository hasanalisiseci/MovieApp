//
//  FirebaseManager.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 17.10.2022.
//

import FirebaseRemoteConfig
import Foundation

class FirebaseManager {
    static let shared = FirebaseManager()

    private let remoteConfig = RemoteConfig.remoteConfig()
    private var titleText = ""

    private init() {
    }

    public func fetchRCValues(completed: @escaping (Result<String, Error>) -> Void) {
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
                    self.titleText = value ?? ""
                    completed(.success(self.titleText))
                }
            } else {
                completed(.failure(error!))
            }
        }
    }
}
