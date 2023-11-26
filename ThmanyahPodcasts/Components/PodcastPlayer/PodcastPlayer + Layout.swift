//
//  PodcastPlayer + Layout.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 24/11/2023.
//

import Foundation
import UIKit
extension PodcastPlayer {
    func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }

    func setupDismissButtonConstraints() {
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.topAnchor, constant: 0),
            dismissButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 100),
            dismissButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -100),
            dismissButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

    func setupPodcastImageViewConstraints() {
        NSLayoutConstraint.activate([
            podcastImageView.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 12),
            podcastImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 24),
            podcastImageView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -24),
            podcastImageView.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.3)
        ])
    }

    func setupProgressSliderConstraints() {
        NSLayoutConstraint.activate([
            progressSlider.topAnchor.constraint(equalTo: podcastImageView.bottomAnchor, constant: 24),
            progressSlider.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 24),
            progressSlider.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -24),
            progressSlider.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    func setupLenthLabelsStackViewConstraints() {
        NSLayoutConstraint.activate([
            lenthLabelsStackView.topAnchor.constraint(equalTo: progressSlider.bottomAnchor, constant: 10),
            lenthLabelsStackView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 24),
            lenthLabelsStackView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -24),
            lenthLabelsStackView.heightAnchor.constraint(equalToConstant: 20)
        ])
        if LocalizationManager.shared.isAppInArabicLanguage() {
            lenthLabelsStackView.addArrangedSubview(podcastMaxLenth)
            lenthLabelsStackView.addArrangedSubview(podcastCurrentLenth)
        } else {
            lenthLabelsStackView.addArrangedSubview(podcastCurrentLenth)
            lenthLabelsStackView.addArrangedSubview(podcastMaxLenth)
        }
    }

    func setupPodcastTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            podcastTitleLabel.topAnchor.constraint(equalTo: lenthLabelsStackView.bottomAnchor, constant: 24),
            podcastTitleLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 24),
            podcastTitleLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -24)
        ])
    }

    func setupPodcastAutherLabelConstraints() {
        NSLayoutConstraint.activate([
            podcastAuther.topAnchor.constraint(equalTo: podcastTitleLabel.bottomAnchor, constant: 4),
            podcastAuther.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 24),
            podcastAuther.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -24)
        ])
    }

    func setupControlsContainerViewConstraints() {
        NSLayoutConstraint.activate([
            controlsViewContainer.topAnchor.constraint(equalTo: podcastAuther.bottomAnchor, constant: 20),
            controlsViewContainer.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 24),
            controlsViewContainer.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -24),
            controlsViewContainer.bottomAnchor.constraint(equalTo: soundSlider.topAnchor, constant: -20)
        ])
    }

    func setupControlsViewConstraints() {
        NSLayoutConstraint.activate([
            controlsView.centerXAnchor.constraint(equalTo: controlsViewContainer.centerXAnchor, constant: 0),
            controlsView.centerYAnchor.constraint(equalTo: controlsViewContainer.centerYAnchor, constant: 0),
            controlsView.widthAnchor.constraint(equalTo: controlsViewContainer.widthAnchor, multiplier: 0.8),
            controlsView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    func setupSoundSliderConstraints() {
        NSLayoutConstraint.activate([
            soundSlider.bottomAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            soundSlider.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 50),
            soundSlider.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -50),
            soundSlider.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    func setupVolumeUpButtonConstraints() {
        NSLayoutConstraint.activate([
            volumeUpButton.heightAnchor.constraint(equalToConstant: 20),
            volumeUpButton.widthAnchor.constraint(equalToConstant: 20),
            volumeUpButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -24),
            volumeUpButton.bottomAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    func setupVolumeDownButtonConstraints() {
        NSLayoutConstraint.activate([
            volumeDownButton.heightAnchor.constraint(equalToConstant: 20),
            volumeDownButton.widthAnchor.constraint(equalToConstant: 20),
            volumeDownButton.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 24),
            volumeDownButton.bottomAnchor.constraint(equalTo: self.containerView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    func setupCollapsedViewConstraints() {
        NSLayoutConstraint.activate([
            self.collapsedView.topAnchor.constraint(equalTo: self.topAnchor),
            self.collapsedView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collapsedView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collapsedView.heightAnchor.constraint(equalToConstant: 64)
        ])
    }
}
