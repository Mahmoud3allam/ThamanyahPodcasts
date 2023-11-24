//
//  PlayListTopActions.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 24/11/2023.
//

import Foundation
import UIKit

class PlayListTopActions: UIView {
    private let backButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.setImage(Images.backIcon.image.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()

    private let hStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 11
        return stackView
    }()

    private let optionButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.setImage(Images.threedots.image.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()

    private let likeButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.setImage(Images.likeButton.image.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layoutUserInterFace()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutUserInterFace() {
        self.addSubViews()
        self.setupBackButtonConstraints()
        self.setupHStackViewConstriants()
    }

    private func addSubViews() {
        self.addSubview(self.backButton)
        self.addSubview(self.hStackView)
        self.superview?.bringSubviewToFront(self)
    }

    private func setupBackButtonConstraints() {
        NSLayoutConstraint.activate([
            self.backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.backButton.heightAnchor.constraint(equalToConstant: 39),
            self.backButton.widthAnchor.constraint(equalToConstant: 39),
            self.backButton.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 40)
        ])
    }

    private func setupHStackViewConstriants() {
        NSLayoutConstraint.activate([
            self.hStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.hStackView.heightAnchor.constraint(equalToConstant: 39),
            self.hStackView.widthAnchor.constraint(equalToConstant: (39 * 2) + 11),
            self.hStackView.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor)
        ])

        self.hStackView.addArrangedSubview(self.likeButton)
        self.hStackView.addArrangedSubview(self.optionButton)
    }
}
