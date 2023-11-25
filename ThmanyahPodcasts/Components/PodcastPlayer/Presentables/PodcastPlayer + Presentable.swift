//
//  PodcastPlayer + Presentable.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 24/11/2023.
//

import Foundation
import UIKit

extension PodcastPlayer {
    struct Presentable {
        var podcastId: String
        var podcastUrl: String
        var podCastTitle: String
        var podCastAuther: String
        var pocCastImage: PodcastImageViewType
        var volumeUpIcon: UIImage?
        var volumeDownIcon: UIImage?
        var playIcon: UIImage?
        var pauseIcon: UIImage?
        var forwardIcon: UIImage?
        var backwardIcon: UIImage?
        var currentTimeLabelDefaultValue: String?
        var maxLenghLabelDefaultValue: String?
        var podCastImageAnimationScale: CGFloat?

        init(podcastId: String,
             podcastUrl: String,
             podCastTitle: String,
             podCastAuther: String,
             pocCastImage: PodcastPlayer.PodcastImageViewType,
             volumeUpIcon: UIImage? = nil,
             volumeDownIcon: UIImage? = nil,
             playIcon: UIImage? = nil,
             pauseIcon: UIImage? = nil,
             forwardIcon: UIImage? = nil,
             backwardIcon: UIImage? = nil,
             currentTimeLabelDefaultValue: String? = nil,
             maxLenghLabelDefaultValue: String? = nil,
             podCastImageAnimationScale: CGFloat? = 0.8)
        {
            self.podcastId = podcastId
            self.podcastUrl = podcastUrl
            self.podCastTitle = podCastTitle
            self.podCastAuther = podCastAuther
            self.pocCastImage = pocCastImage
            self.volumeUpIcon = volumeUpIcon
            self.volumeDownIcon = volumeDownIcon
            self.playIcon = playIcon
            self.pauseIcon = pauseIcon
            self.forwardIcon = forwardIcon
            self.backwardIcon = backwardIcon
            self.currentTimeLabelDefaultValue = currentTimeLabelDefaultValue
            self.maxLenghLabelDefaultValue = maxLenghLabelDefaultValue
            self.podCastImageAnimationScale = podCastImageAnimationScale
        }
    }

    enum PodcastImageViewType {
        case url(String)
        case local(UIImage?)
    }
}
