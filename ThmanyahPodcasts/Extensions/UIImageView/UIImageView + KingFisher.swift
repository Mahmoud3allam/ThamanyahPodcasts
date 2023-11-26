//
//  UIImageView + KingFisher.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 26/11/2023.
//

import Foundation
import Kingfisher
import UIKit

extension UIImageView {
    func setImage(from urlString: String?, placeholder: UIImage? = nil) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.image = placeholder
            return
        }

        let options: KingfisherOptionsInfo = [
            .transition(.fade(0.2)),
            .scaleFactor(UIScreen.main.scale),
            .cacheOriginalImage
        ]

        self.kf.setImage(with: url, placeholder: placeholder, options: options)
    }
}
