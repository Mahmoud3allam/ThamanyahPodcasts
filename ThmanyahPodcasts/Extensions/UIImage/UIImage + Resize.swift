//
//  UIImage + Resize.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 25/11/2023.
//

import Foundation
// Extension to resize UIImage
import UIKit
extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}
