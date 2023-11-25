//
//  PodcastPlayer + PlayerControlsViewDelegate.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 25/11/2023.
//

import AVKit
import Foundation
import UIKit

extension PodcastPlayer: PlayerControlsViewDelegate {
    func didTappedPlayPauseButton() {
        if self.player.timeControlStatus == .paused {
            self.player.play()
            self.controlsView.setPlayPauseImage(image: self.presentable?.pauseIcon ?? UIImage(systemName: "pause.fill"))
            self.transformPodcastImageView(toIdentity: true)
        } else {
            self.player.pause()
            self.controlsView.setPlayPauseImage(image: self.presentable?.playIcon ?? UIImage(systemName: "play.fill"))
            self.transformPodcastImageView()
        }
    }

    func didTappedForward() {
        let tenSeconds = CMTimeMake(value: 10, timescale: 1)
        let seekingTime = CMTimeAdd(self.player.currentTime(), tenSeconds)
        self.player.seek(to: seekingTime)
    }

    func didTappedBackward() {
        let tenSeconds = CMTimeMake(value: -10, timescale: 1)
        let seekingTime = CMTimeAdd(self.player.currentTime(), tenSeconds)
        self.player.seek(to: seekingTime)
    }
}
