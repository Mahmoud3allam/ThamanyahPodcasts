//
//  StretchyHeaderView.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 24/11/2023.
//

import Kingfisher
import UIKit

class StretchyHeaderView: UIView {
    lazy var playListNavigationBar: PlayListTopActions = {
        var view = PlayListTopActions()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var playListBottomActions: PlayListBottomActions = {
        var view = PlayListBottomActions()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray.withAlphaComponent(0.5)
        return imageView
    }()

    private let containerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var titleLabel: UILabel = {
        var label = UILabel()
        let typography = Typography(size: .header4, weight: .semiBold, color: .white)
        label.font = typography.font
        label.textColor = typography.color
        label.numberOfLines = 0
        label.text = "                                           "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var descriptionLabel: UILabel = {
        var label = UILabel()
        let typography = Typography(size: .caption, weight: .regular, color: .white)
        label.font = typography.font
        label.textColor = typography.color
        label.numberOfLines = 0
        label.text = "                                      "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var imageViewHeight = NSLayoutConstraint()
    private var imageViewBottom = NSLayoutConstraint()
    private var containerViewHeight = NSLayoutConstraint()
    let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUserInterFace()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutUserInterFace() {
        self.addSubViews()
        self.setupBaseConstraints()
        self.setupPlayListNavigationBar()
        self.setupPlayListBottonActions()
        self.setupTitleLabelConstraints()
        self.setupDescriptionLabelConstraints()
    }

    private func addSubViews() {
        addSubview(containerView)
        containerView.addSubview(imageView)
        addSubview(self.playListNavigationBar)
        addSubview(self.playListBottomActions)
        addSubview(self.titleLabel)
        addSubview(self.descriptionLabel)
    }

    private func setupBaseConstraints() {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: containerView.widthAnchor),
            centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: heightAnchor)
        containerViewHeight.isActive = true

        imageViewBottom = imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewBottom.isActive = true

        imageViewHeight = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageViewHeight.isActive = true
    }

    private func setupPlayListNavigationBar() {
        NSLayoutConstraint.activate([
            self.playListNavigationBar.topAnchor.constraint(equalTo: self.topAnchor),
            self.playListNavigationBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.playListNavigationBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.playListNavigationBar.heightAnchor.constraint(equalToConstant: 45)
        ])
    }

    private func setupPlayListBottonActions() {
        NSLayoutConstraint.activate([
            self.playListBottomActions.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
            self.playListBottomActions.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.playListBottomActions.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.playListBottomActions.heightAnchor.constraint(equalToConstant: 45)
        ])
    }

    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: playListNavigationBar.bottomAnchor, constant: 100),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -22),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -16)
        ])
    }

    private func setupDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            self.descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -22),
            self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20)

        ])
    }

    public func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }

    func setupGradientLayer() {
        gradientLayer.name = "Gradient"
        gradientLayer.frame = self.imageView.frame
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.4, 1]
        self.containerView.layer.addSublayer(gradientLayer)
    }

    func setPlaylistHeaderData(dataSource: PlaylistDataSource) {
        DispatchQueue.main.async {
            self.setupGradientLayer()
            self.setImage(url: dataSource.playlistImageUrl)
            self.titleLabel.text = dataSource.playlistTitle
            self.descriptionLabel.text = dataSource.playListDescription
        }
    }

    func setImage(url: String) {
        self.imageView.kf.setImage(with: URL(string: url), completionHandler: { result in
            switch result {
            case let .success(value):
                // Image is loaded successfully
                // Resize the image to fit the UIImageView
                let resizedImage = value.image.resized(to: self.imageView.bounds.size)

                // Set the resized image to the UIImageView
                self.imageView.image = resizedImage

                print("Image loaded: \(value.source.url?.absoluteString ?? "")")
            case let .failure(error):
                // Handle error
                print("Error loading image: \(error.localizedDescription)")
            }
        })
    }
}
