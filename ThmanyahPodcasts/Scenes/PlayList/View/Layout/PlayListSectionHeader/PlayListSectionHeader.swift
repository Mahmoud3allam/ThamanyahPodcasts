//
//  PlayListSectionHeader.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 24/11/2023.
//

import Foundation
import UIKit

class PlayListSectionHeader: UIView {
    var titleLabel: UILabel = {
        var label = UILabel()
        let typography = Typography(size: .body, weight: .medium, color: .black)
        label.font = typography.font
        label.textColor = typography.color
        label.numberOfLines = 1
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var descriptionLabel: UILabel = {
        var label = UILabel()
        let typography = Typography(size: .tabBar, weight: .thin, color: .black)
        label.font = typography.font
        label.textColor = typography.color
        label.numberOfLines = 1
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var sepratorView: UIView = {
        var view = UIView()
        view.backgroundColor = Colors.chimneySweep.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.clipsToBounds = true
        self.layer.cornerRadius = 12
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.layoutUserInterFace()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutUserInterFace() {
        self.addSubViews()
        self.setupTitleLabelConstraints()
        self.setupTitleDescriptionConstraints()
        self.setupSepratorViewConstraints()
    }

    private func addSubViews() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.sepratorView)
    }

    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10),
//            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func setupTitleDescriptionConstraints() {
        NSLayoutConstraint.activate([
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10),
//            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func setupSepratorViewConstraints() {
        NSLayoutConstraint.activate([
            self.sepratorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.sepratorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),

            self.sepratorView.heightAnchor.constraint(equalToConstant: 1),
            self.sepratorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
