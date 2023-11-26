//
//  Typography.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 23/11/2023.
//

import Foundation
import UIKit

public struct Typography {
    public var size: FontSize
    public var weight: FontWeight
    public var color: UIColor?
    public var alpha: CGFloat? = 1

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

    public var font: UIFont {
        UIFont(name: weight.rawValue, size: size.rawValue) ?? UIFont.systemFont(ofSize: 15)
    }
}
