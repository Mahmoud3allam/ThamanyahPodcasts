//
//  PodcastPlayerStyle.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 24/11/2023.
//

import Foundation
import UIKit
struct PodcastPlayerStyle {
    var backgroundColor: UIColor
    var dismissButtonTypography: Typography?
    var podcastImageContentMode: UIView.ContentMode?
    var titleLabelTypography: Typography?
    var autherLabelTypography: Typography?
    var currentLenthTypography: Typography?
    var maxLenthTypography: Typography?
    var controlButtonsTintColor: UIColor?
    var minimizedViewBackground: UIColor?

    init(backgroundColor: UIColor,
         dismissButtonTypography: Typography?,
         podcastImageContentMode: UIView.ContentMode?,
         titleLabelTypography: Typography?,
         autherLabelTypography: Typography?,
         currentLenthTypography: Typography?,
         maxLenthTypography: Typography?,
         controlButtonsTintColor: UIColor?,
         minimizedViewBackground: UIColor?)
    {
        self.backgroundColor = backgroundColor
        self.dismissButtonTypography = dismissButtonTypography
        self.podcastImageContentMode = podcastImageContentMode
        self.titleLabelTypography = titleLabelTypography
        self.autherLabelTypography = autherLabelTypography
        self.currentLenthTypography = currentLenthTypography
        self.maxLenthTypography = maxLenthTypography
        self.controlButtonsTintColor = controlButtonsTintColor
        self.minimizedViewBackground = minimizedViewBackground
    }
}

extension PodcastPlayerStyle {
    enum PredefinedStyles {
        case standard

        var value: PodcastPlayerStyle {
            switch self {
            case .standard:
                return PodcastPlayerStyle(backgroundColor: .white,
                                          dismissButtonTypography: Typography(size: .body,
                                                                              weight: .semiBold,
                                                                              color: .purple),
                                          podcastImageContentMode: .scaleAspectFill,
                                          titleLabelTypography: Typography(size: .body,
                                                                           weight: .medium,
                                                                           color: .black),
                                          autherLabelTypography: Typography(size: .body,
                                                                            weight: .semiBold,
                                                                            color: .purple),
                                          currentLenthTypography: Typography(size: .caption,
                                                                             weight: .medium,
                                                                             color: .black),
                                          maxLenthTypography: Typography(size: .caption,
                                                                         weight: .medium,
                                                                         color: .black),
                                          controlButtonsTintColor: .black,
                                          minimizedViewBackground: .white)
            }
        }
    }
}
