//
//  PodcastPlayer + Gestures.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 25/11/2023.
//

import Foundation
import UIKit

extension PodcastPlayer {
    func addTapGesture() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleExpandingTap)))
    }

    func addPanGestures() {
        self.collapsedView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGestureExpanding)))
        self.containerView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanCollapsing)))
    }

    @objc func handleExpandingTap() {
        if let window = UIApplication.shared.windows.last { $0.isKeyWindow } {
            if let tabBarController = window.rootViewController as? MainTabBarController {
                tabBarController.expandPodcastPlayer()
                collapsedView.alpha = 0
                self.containerView.alpha = 1
            }
        }
    }

    @objc func handlePanGestureExpanding(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: self.superview)
            print(translation.y)
            self.transform = CGAffineTransform(translationX: 0, y: translation.y)
            self.collapsedView.alpha = 1 + translation.y / 300
            self.containerView.alpha = -translation.y / 300
            if let window = UIApplication.shared.windows.last { $0.isKeyWindow } {
                self.containerView.heightAnchor.constraint(equalTo: window.heightAnchor, multiplier: 1).isActive = true
            }
        case .ended:
            let translation = gesture.translation(in: self.superview)
            let velocity = gesture.velocity(in: self.superview)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1) {
                self.transform = .identity

                if translation.y < -200 || velocity.y < -500 {
                    if let window = UIApplication.shared.windows.last { $0.isKeyWindow } {
                        if let tabBarController = window.rootViewController as? MainTabBarController {
                            tabBarController.expandPodcastPlayer()
                        }
                        self.collapsedView.alpha = 0
                        self.containerView.alpha = 1
                    }
                } else {
                    self.collapsedView.alpha = 1
                    self.containerView.alpha = 0
                }
            }
        default: return
        }
    }

    @objc func handlePanCollapsing(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: self.superview)
            self.containerView.transform = CGAffineTransform(translationX: 0, y: translation.y)
        case .ended:
            let translation = gesture.translation(in: self.superview)
            let velocity = gesture.velocity(in: self.superview)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseOut) {
                self.containerView.transform = .identity
                if translation.y > 200 || velocity.y < 500 {
                    if let window = UIApplication.shared.windows.last(where: { $0.isKeyWindow }) {
                        if let tabBarController = window.rootViewController as? MainTabBarController {
                            tabBarController.collapsePodcastPlayer()
                            self.collapsedView.alpha = 1
                        }
                    }
                }
            }
        default:
            return
        }
    }
}
