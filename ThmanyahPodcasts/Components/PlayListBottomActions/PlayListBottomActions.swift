//
//  PlayListBottomActions.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 24/11/2023.
//

import Foundation
import UIKit

class PlayListBottomActions: UIView {
    private let shuffleButton: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "shuffle")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let imageString = NSMutableAttributedString(attachment: attachment)
        let seprator = NSAttributedString(string: "  ")
        let textString = NSAttributedString(string: "Shuffle".localize)
        imageString.append(seprator)
        imageString.append(textString)
        label.attributedText = imageString
        label.sizeToFit()
        let typography = Typography(size: .body, weight: .bold, color: .white)
        label.font = typography.font
        label.textColor = typography.color
        label.tintColor = typography.color
        label.backgroundColor = Colors.haileyBlue.color
        label.layer.cornerRadius = 20
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
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

    private let playButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.backgroundColor = Colors.haileyBlue.color
        return button
    }()

    private let nextButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setImage(UIImage(systemName: "arrow.down"), for: .normal)
        button.backgroundColor = Colors.haileyBlue.color
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
        self.addSubview(self.shuffleButton)
        self.addSubview(self.hStackView)
    }

    private func setupBackButtonConstraints() {
        NSLayoutConstraint.activate([
            self.shuffleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 31),
            self.shuffleButton.heightAnchor.constraint(equalToConstant: 39),
            self.shuffleButton.widthAnchor.constraint(equalToConstant: 170),
            self.shuffleButton.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 40)
        ])
    }

    private func setupHStackViewConstriants() {
        NSLayoutConstraint.activate([
            self.hStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.hStackView.heightAnchor.constraint(equalToConstant: 39),
            self.hStackView.widthAnchor.constraint(equalToConstant: (39 * 2) + 11),
            self.hStackView.centerYAnchor.constraint(equalTo: self.shuffleButton.centerYAnchor)
        ])

        self.hStackView.addArrangedSubview(self.nextButton)
        self.hStackView.addArrangedSubview(self.playButton)

        nextButton.layer.cornerRadius = 39 / 2
        playButton.layer.cornerRadius = 39 / 2
    }
}
