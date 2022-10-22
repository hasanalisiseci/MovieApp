//
//  MADetailImageView.swift
//  MovieApp
//
//  Created by Hasan Ali Şişeci on 22.10.2022.
//

import Kingfisher
import UIKit
class MADetailImageView: UIImageView {
    let cache = NetworkManager().cache
    let placeholderImage = UIImage(named: "placeholder")!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        clipsToBounds = true
        image = placeholderImage
        contentMode = .scaleToFill
        translatesAutoresizingMaskIntoConstraints = false
    }

    func downloadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        guard let url = URL(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url)

        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
            switch result {
            case let .success(value):
                DispatchQueue.main.async {
                    self.image = value.image
                }
            case let .failure(error):
                print("Error: \(error)")
            }
        }
    }
}
