//
//  Typography.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 23/11/2023.
//

import Foundation
import UIKit

public struct Typography {
    public var size: FontSize
    public var weight: FontWeight
    public var color: UIColor?
    public var alpha: CGFloat? = 1

    /// Initialize a new DDFont instance with the provided settings.
    /// - Parameters:
    ///   - size: The size of the font.
    ///   - weight: The weight or thickness of the font.
    ///   - color: The color of the font.
    ///   - alpha: the alpha needed for the color
    public init(size: FontSize,
                weight: FontWeight,
                color: UIColor? = .clear,
                alpha: CGFloat? = 1)
    {
        self.size = size
        self.weight = weight
        self.color = color
        self.alpha = alpha
    }

    /// Get the UIFont instance based on the stored `size` and `weight`.
    /// If the specified font is not available, it falls back to the system font with a default size of 15.
    /// - Returns: The corresponding UIFont instance.
    public var font: UIFont {
        UIFont(name: weight.rawValue, size: size.rawValue) ?? UIFont.systemFont(ofSize: 15)
    }
}
