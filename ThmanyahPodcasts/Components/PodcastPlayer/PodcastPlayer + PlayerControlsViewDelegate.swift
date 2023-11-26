//
//  PodcastPlayer + PlayerControlsViewDelegate.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 25/11/2023.
//

import AVKit
import Foundation
import UIKit

extension PodcastPlayer: PlayerControlsViewDelegate {
    func didTappedPlayPauseButton() {
        if player.timeControlStatus == .paused {
            play()
        } else {
            pause()
        }
    }

    private func play() {
        player.play()
        controlsView.setPlayPauseImage(image: presentable?.pauseIcon ?? UIImage(systemName: "pause.fill"))
        applyPodcastImageTransform(toIdentity: true)
    }

    private func pause() {
        player.pause()
        controlsView.setPlayPauseImage(image: presentable?.playIcon ?? UIImage(systemName: "play.fill"))
        applyPodcastImageTransform()
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
