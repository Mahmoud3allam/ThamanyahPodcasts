//
//  EposidesCell.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 24/11/2023.
//

import Foundation
import Kingfisher
import UIKit
class EposidesCell: UITableViewCell {
    let eposideImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.image = Images.podcastHeaderImage.image
        return imageView
    }()

    lazy var vStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 6
        return stackView
    }()

    var eposideTitleLabel: UILabel = {
        var label = UILabel()
        let typography = Typography(size: .caption, weight: .medium, color: .black)
        label.font = typography.font
        label.textColor = typography.color
        label.numberOfLines = 0
        label.text = "              "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var podcastNameLabel: UILabel = {
        var label = UILabel()
        let typography = Typography(size: .tabBar, weight: .thin, color: .black)
        label.font = typography.font
        label.textColor = typography.color
        label.numberOfLines = 0
        label.text = "       "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var podcastDateLabel: UILabel = {
        var label = UILabel()
        let typography = Typography(size: .tabBar, weight: .thin, color: .black)
        label.font = typography.font
        label.textColor = typography.color
        label.numberOfLines = 0
        label.text = "          "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let playButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.backgroundColor = Colors.haileyBlue.color
        button.layer.cornerRadius = 32 / 2
        button.addTarget(self, action: #selector(didTappedPlayButton), for: .touchUpInside)
        return button
    }()

    private let optionButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false

        button.setImage(Images.menu.image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 32 / 2
        return button
    }()

    var sepratorView: UIView = {
        var view = UIView()
        view.backgroundColor = Colors.chimneySweep.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var onTapPlay: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = Colors.background.color
        self.layotUserInterFace()
        self.showSkeleton()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubViews() {
        self.contentView.addSubview(self.eposideImageView)
        self.contentView.addSubview(self.vStackView)
        self.contentView.addSubview(self.sepratorView)
        self.contentView.addSubview(self.optionButton)
        self.contentView.addSubview(self.playButton)
    }

    private func layotUserInterFace() {
        self.addSubViews()
        self.setupEposideImageViewConstraints()
        self.setupVStackViewConstraints()
        self.setupOptionButtonConstraints()
        self.setupPlayButtonConstraints()
        self.setupSepratorViewConstraints()
    }

    private func setupEposideImageViewConstraints() {
        NSLayoutConstraint.activate([
            self.eposideImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.eposideImageView.heightAnchor.constraint(equalToConstant: 76),
            self.eposideImageView.widthAnchor.constraint(equalToConstant: 76),
            self.eposideImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }

    private func setupVStackViewConstraints() {
        NSLayoutConstraint.activate([
            self.vStackView.leadingAnchor.constraint(equalTo: self.eposideImageView.trailingAnchor, constant: 15),
            self.vStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            self.vStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
            self.vStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -85)
        ])
        self.vStackView.addArrangedSubview(self.eposideTitleLabel)
        self.vStackView.addArrangedSubview(self.podcastNameLabel)
        self.vStackView.addArrangedSubview(self.podcastDateLabel)
    }

    private func setupOptionButtonConstraints() {
        NSLayoutConstraint.activate([
            self.optionButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.optionButton.heightAnchor.constraint(equalToConstant: 32),
            self.optionButton.widthAnchor.constraint(equalToConstant: 32),
            self.optionButton.topAnchor.constraint(equalTo: self.eposideTitleLabel.topAnchor, constant: 0)
        ])
    }

    private func setupPlayButtonConstraints() {
        NSLayoutConstraint.activate([
            self.playButton.trailingAnchor.constraint(equalTo: self.optionButton.leadingAnchor, constant: 0),
            self.playButton.heightAnchor.constraint(equalToConstant: 32),
            self.playButton.widthAnchor.constraint(equalToConstant: 32),
            self.playButton.topAnchor.constraint(equalTo: self.optionButton.topAnchor, constant: 0)
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

    @objc func didTappedPlayButton() {
        self.onTapPlay?()
    }

    func showSkeleton() {
        self.eposideImageView.enableSkeleton(enable: true)
        self.eposideTitleLabel.enableSkeleton(enable: true)
        self.podcastNameLabel.enableSkeleton(enable: true)
        self.podcastDateLabel.enableSkeleton(enable: true)
        self.playButton.isHidden = true
        self.optionButton.enableSkeleton(enable: true)
    }

    func hideSkeleton() {
        self.eposideImageView.enableSkeleton(enable: false)
        self.eposideTitleLabel.enableSkeleton(enable: false)
        self.podcastNameLabel.enableSkeleton(enable: false)
        self.podcastDateLabel.enableSkeleton(enable: false)
        self.playButton.isHidden = false
        self.optionButton.enableSkeleton(enable: false)
    }
}

extension EposidesCell: EposideCellDataSourceProtocol {
    func setData(dataSource: EposideCellDataSource) {
        self.eposideImageView.setImage(from: dataSource.imageUrl)
        self.eposideTitleLabel.text = dataSource.title ?? ""
        self.podcastNameLabel.text = dataSource.name
        self.podcastDateLabel.text = dataSource.displayableDateTimeInfo
        self.hideSkeleton()
    }
}
