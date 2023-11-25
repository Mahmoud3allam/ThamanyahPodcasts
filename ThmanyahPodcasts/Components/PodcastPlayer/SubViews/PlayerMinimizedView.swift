//
//  PlayerMinimizedView.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 24/11/2023.
//

import Foundation
import UIKit
class PlayerMinimizedView: UIView {
    var podcastImageView: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 1
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()

    var sepratorView: UIView = {
        var view = UIView()
        view.backgroundColor = Colors.chimneySweep.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var podcastTitleLabel: UILabel = {
        var label = UILabel()
        let typography = Typography(size: .body,
                                    weight: .medium,
                                    color: .black)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = typography.color
        label.font = typography.font
        label.numberOfLines = 1
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.semanticContentAttribute = .forceLeftToRight
        self.layoutUserInterFace()
        self.setupSepratorViewConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layoutUserInterFace() {
        self.addSubView()
        self.setupPodcatImageView()
        self.setupPodcatTitleLabel()
    }

    private func addSubView() {
        self.addSubview(self.podcastImageView)
        self.addSubview(self.podcastTitleLabel)
        self.addSubview(self.sepratorView)
    }

    private func setupPodcatImageView() {
        NSLayoutConstraint.activate([
            self.podcastImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.podcastImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.podcastImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            self.podcastImageView.widthAnchor.constraint(equalTo: self.podcastImageView.heightAnchor, multiplier: 1)

        ])
    }

    private func setupPodcatTitleLabel() {
        NSLayoutConstraint.activate([
            self.podcastTitleLabel.leadingAnchor.constraint(equalTo: self.podcastImageView.trailingAnchor, constant: 10),
            self.podcastTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.podcastTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            self.podcastTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)

        ])
    }

    private func setupSepratorViewConstraints() {
        NSLayoutConstraint.activate([
            self.sepratorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            self.sepratorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.sepratorView.heightAnchor.constraint(equalToConstant: 1),
            self.sepratorView.bottomAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
}
