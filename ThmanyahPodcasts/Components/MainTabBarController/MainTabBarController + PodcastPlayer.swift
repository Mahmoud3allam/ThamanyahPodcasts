//
//  MainTabBarController + PodcastPlayer.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 25/11/2023.
//

import Foundation
import UIKit

extension MainTabBarController {
    @objc func collapsePodcastPlayer() {
        self.expandedPlayerTopAnchor?.isActive = false
        self.collapsedPlayerTopAnchor?.isActive = true
        self.viewDidLayoutSubviews()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
            self.tabBar.isHidden = false
        }
    }

    @objc func expandPodcastPlayer() {
        self.expandedPlayerTopAnchor?.isActive = true
        self.expandedPlayerTopAnchor?.constant = 0
        self.collapsedPlayerTopAnchor?.isActive = false
        self.viewDidLayoutSubviews()
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.view.layoutIfNeeded()
            self.tabBar.isHidden = true
        }
    }

    func settingUpPlayerDetailsView() {
        self.view.insertSubview(self.podcastPlayer, belowSubview: self.tabBar)
        self.expandedPlayerTopAnchor = self.podcastPlayer.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height + 200)
        self.expandedPlayerTopAnchor?.isActive = true
        self.collapsedPlayerTopAnchor = self.podcastPlayer.topAnchor.constraint(equalTo: self.tabBar.topAnchor, constant: -64)
        NSLayoutConstraint.activate([
            self.podcastPlayer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.podcastPlayer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.podcastPlayer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
