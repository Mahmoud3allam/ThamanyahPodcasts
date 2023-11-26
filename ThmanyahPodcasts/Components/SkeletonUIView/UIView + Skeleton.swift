//
//  UIView + Skeleton.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 24/11/2023.
//

import Foundation
import UIKit

extension UIView {
    /// Enables or disables the skeleton effect on the view.
    ///
    /// - Parameters:
    ///   - color: The color of the skeleton view. Default is a light gray color.
    ///   - enable: A boolean value indicating whether to enable or disable the skeleton effect.
    public func enableSkeleton(with color: UIColor = UIColor(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, alpha: 1.0), enable: Bool) {
        isUserInteractionEnabled = !enable

        if enable, !isAnimating() {
            // Create the animating gradient color
            let animatingGradientColor = UIColor(red: 239.0 / 255.0, green: 243.0 / 255.0, blue: 244.0 / 255.0, alpha: 0.2)
            // Create the skeleton view
            let gradientView = SkeletonUIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
            gradientView.animatingGriadintColor = animatingGradientColor
            gradientView.tag = -1
            gradientView.backgroundColor = color
            gradientView.layer.cornerRadius = 0
            gradientView.clipsToBounds = true

            // Add the skeleton view to the current view
            addSubview(gradientView)
            gradientView.fillInView(self)
            bringSubviewToFront(gradientView)

            // Add the gradient sublayer with animation to the skeleton view
            addGradientSublayerWithAnimation(gradientView: gradientView, color: animatingGradientColor)
        } else if !enable, isAnimating() {
            // Disable the skeleton effect by removing the skeleton view
            viewWithTag(-1)?.removeFromSuperview()
        }
    }

    /// Checks if the skeleton animation is currently active.
    ///
    /// - Returns: A boolean value indicating whether the skeleton animation is active.
    private func isAnimating() -> Bool {
        return viewWithTag(-1) != nil
    }

    /// Adds a gradient sublayer with animation to the specified view.
    ///
    /// - Parameters:
    ///   - gradientView: The view to which the gradient sublayer should be added.
    ///   - color: The color of the gradient.
    func addGradientSublayerWithAnimation(gradientView: UIView, color: UIColor) {
        gradientView.layoutIfNeeded()

        // Create the gradient layer
        let gradientLayer = CAGradientLayer(layer: gradientView.layer)
        gradientLayer.colors = [color.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: gradientView.frame.width, height: gradientView.frame.height)

        // Create the animations for the gradient layer
        let startPointAnim = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.startPoint))
        startPointAnim.fromValue = CGPoint(x: -1, y: 0.5)
        startPointAnim.toValue = CGPoint(x: 1, y: 0.5)

        let endPointAnim = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.endPoint))
        endPointAnim.fromValue = CGPoint(x: 0, y: 0.5)
        endPointAnim.toValue = CGPoint(x: 2, y: 0.5)

        // Create the animation group
        let animGroup = CAAnimationGroup()
        animGroup.animations = [startPointAnim, endPointAnim]
        animGroup.duration = 1.5
        animGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        animGroup.repeatCount = .infinity

        // Add the animation group to the gradient layer
        gradientLayer.add(animGroup, forKey: "skeletonAnimation")

        // Add the gradient layer to the skeleton view
        gradientView.layer.addSublayer(gradientLayer)

        gradientView.updateConstraintsIfNeeded()
        gradientView.layoutIfNeeded()
    }

    /// Fills the specified container view with the current view.
    ///
    /// - Parameter container: The container view.
    func fillInView(_ container: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        frame = container.frame
        container.addSubview(self)
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: container.leadingAnchor),
            trailingAnchor.constraint(equalTo: container.trailingAnchor),
            topAnchor.constraint(equalTo: container.topAnchor),
            bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
}
