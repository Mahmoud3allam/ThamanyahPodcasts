//
//  PodcastPlayer + Sliders.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 25/11/2023.
//

import AVKit
import Foundation
import UIKit

extension PodcastPlayer {
    @objc func controlSliderValueDidChange(sender: UISlider) {
        guard let duration = self.player.currentItem?.duration else {
            return
        }
        let secondsDuration = CMTimeGetSeconds(duration)
        let timeToSeekInSeconds = Float64(sender.value) * secondsDuration
        let seekingTime = CMTimeMakeWithSeconds(timeToSeekInSeconds, preferredTimescale: 1)
        self.player.seek(to: seekingTime)
        self.player.pause()
        self.controlsView.setPlayPauseImage(image: self.presentable?.playIcon ?? UIImage(systemName: "play.fill"))
        self.applyPodcastImageTransform()
    }

    @objc func volumeSliderValueDidChange(sender: UISlider) {
        self.player.volume = sender.value
    }

    func updateProgressSlider() {
        let currentTimeSeconds = CMTimeGetSeconds(self.player.currentTime())
        let maxDuration = CMTimeGetSeconds(self.player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let progressPrecentage = currentTimeSeconds / maxDuration
        self.progressSlider.value = Float(progressPrecentage)
    }
}
