//
//  PlayerControlsView.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 24/11/2023.
//

import Foundation
import UIKit

protocol PlayerControlsViewDelegate: AnyObject {
    func didTappedPlayPauseButton()
    func didTappedForward()
    func didTappedBackward()
}

class PlayerControlsView: UIView {
    private lazy var forwardButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTappedForWard), for: .touchUpInside)
        return button
    }()

    private lazy var playPauseButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFill
        button.contentMode = .scaleAspectFill
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTappedPlayPauseButton), for: .touchUpInside)
        return button
    }()

    private lazy var backwardButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTappedBackWard), for: .touchUpInside)
        return button
    }()

    var style: PlayerControlsViewStyle? {
        didSet {
            if let unwrappedStyle = style {
                self.backwardButton.tintColor = unwrappedStyle.buttonsTintColor
                self.playPauseButton.tintColor = unwrappedStyle.buttonsTintColor
                self.forwardButton.tintColor = unwrappedStyle.buttonsTintColor
            }
        }
    }

    weak var delegate: PlayerControlsViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.semanticContentAttribute = .forceLeftToRight
        layoutUserInterFace()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutUserInterFace() {
        addSubViews()
        setupPlayPauseButtonConstraints()
        setupBackwardButtonConstraints()
        setupForwardButtonConstraints()
    }

    private func addSubViews() {
        addSubview(playPauseButton)
        addSubview(backwardButton)
        addSubview(forwardButton)
    }

    private func setupPlayPauseButtonConstraints() {
        NSLayoutConstraint.activate([
            playPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playPauseButton.heightAnchor.constraint(equalToConstant: 70),
            playPauseButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    }

    private func setupBackwardButtonConstraints() {
        NSLayoutConstraint.activate([
            backwardButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backwardButton.trailingAnchor.constraint(equalTo: playPauseButton.leadingAnchor, constant: -30),
            backwardButton.heightAnchor.constraint(equalToConstant: 50),
            backwardButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupForwardButtonConstraints() {
        NSLayoutConstraint.activate([
            forwardButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            forwardButton.leadingAnchor.constraint(equalTo: playPauseButton.trailingAnchor, constant: 30),
            forwardButton.heightAnchor.constraint(equalToConstant: 50),
            forwardButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func didTappedPlayPauseButton() {
        delegate?.didTappedPlayPauseButton()
    }

    @objc func didTappedForWard() {
        delegate?.didTappedForward()
    }

    @objc func didTappedBackWard() {
        delegate?.didTappedBackward()
    }

    func setPlayPauseImage(image: UIImage?) {
        self.playPauseButton.setImage(image, for: .normal)
    }

    func setBackwardImage(image: UIImage?) {
        self.backwardButton.setImage(image, for: .normal)
    }

    func setForwardImage(image: UIImage?) {
        self.forwardButton.setImage(image, for: .normal)
    }
}
