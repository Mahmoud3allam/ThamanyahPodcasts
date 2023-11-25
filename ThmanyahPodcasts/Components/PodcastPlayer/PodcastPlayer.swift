//
//  PodcastPlayer.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 24/11/2023.
//

import AVKit
import Foundation
import Kingfisher
import UIKit

protocol PodcastPlayerDataSource {
    func configure(presentable: PodcastPlayer.Presentable)
}

class PodcastPlayer: UIView {
    lazy var collapsedView: PlayerMinimizedView = {
        var view = PlayerMinimizedView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()

    lazy var containerView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var closeButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitle("Minimize".localize, for: .normal)
        button.addTarget(self, action: #selector(didTappedDismissButton), for: .touchUpInside)
        return button
    }()

    var podcastImageView: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()

    var progressSlider: UISlider = {
        var slider = UISlider()
        slider.maximumValue = 1
        slider.minimumValue = 0
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(controlSliderValueDidChange(sender:)), for: .valueChanged)
        slider.semanticContentAttribute = .forceLeftToRight
        return slider
    }()

    var hStackView: UIStackView = {
        var stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    var podcastCurrentLenth: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    var podcastMaxLenth: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = LocalizationManager.shared.isAppInArabicLanguage() ? .left : .right
        label.textAlignment = .right
        label.numberOfLines = 1
        return label
    }()

    var podcastTitleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    var podcastAuther: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    var controlsViewContainer: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var controlsView: PlayerControlsView = {
        var view = PlayerControlsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var soundSlider: UISlider = {
        var slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(volumeSliderValueDidChange(sender:)), for: .valueChanged)
        slider.semanticContentAttribute = .forceLeftToRight
        return slider
    }()

    lazy var volumeUpButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        return button
    }()

    lazy var volumeDownButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        return button
    }()

    lazy var player: AVPlayer = {
        let player = AVPlayer()
        player.automaticallyWaitsToMinimizeStalling = false
        return player
    }()

    var style: PodcastPlayerStyle? {
        didSet {
            if let unwrappedStyle = style {
                self.updateStyle(style: unwrappedStyle)
            }
        }
    }

    var presentable: PodcastPlayer.Presentable?
    private var playerItemBufferEmptyObserver: NSKeyValueObservation?
    private var playerItemBufferKeepUpObserver: NSKeyValueObservation?
    private var playerItemBufferFullObserver: NSKeyValueObservation?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.subviews.forEach { $0.semanticContentAttribute = .forceLeftToRight }
        self.layoutUserInterFace()
        self.observePlayerExactPlaying()
        self.observeTrackTime()
        self.addTapGesture()
        self.addPanGestures()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func layoutUserInterFace() {
        addSubViews()
        addContainerView()
        addDismissButton()
        addPodcastImageView()
        addProgressSlider()
        addLenthStack()
        addPodcastTitleLabel()
        addPodcastAutherLabel()
        addcontrolsViewContainer()
        addControlsView()
        addSoundSlider()
        addVolumeUpButton()
        addVolumeDownButton()
        addCollapsedView()
    }

    private func addSubViews() {
        self.addSubview(self.containerView)
        self.containerView.addSubview(closeButton)
        self.containerView.addSubview(podcastImageView)
        self.containerView.addSubview(progressSlider)
        self.containerView.addSubview(hStackView)
        self.containerView.addSubview(podcastTitleLabel)
        self.containerView.addSubview(podcastAuther)
        self.containerView.addSubview(controlsViewContainer)
        self.containerView.addSubview(controlsView)
        self.containerView.addSubview(soundSlider)
        self.containerView.addSubview(volumeUpButton)
        self.containerView.addSubview(volumeDownButton)
        self.addSubview(collapsedView)
    }

    private func updateStyle(style: PodcastPlayerStyle) {
        self.containerView.backgroundColor = style.backgroundColor
        self.collapsedView.backgroundColor = style.minimizedViewBackground ?? style.backgroundColor
        if let dismissButtonTypography = style.dismissButtonTypography {
            self.closeButton.titleLabel?.font = dismissButtonTypography.font
            self.closeButton.titleLabel?.textColor = dismissButtonTypography.color
            self.closeButton.tintColor = dismissButtonTypography.color
        }
        self.podcastImageView.contentMode = style.podcastImageContentMode ?? .scaleAspectFill
        if let titleLabelTypography = style.titleLabelTypography {
            self.podcastTitleLabel.textColor = titleLabelTypography.color
            self.podcastTitleLabel.font = titleLabelTypography.font
        }
        if let autherLabelTypography = style.autherLabelTypography {
            self.podcastAuther.textColor = autherLabelTypography.color
            self.podcastAuther.font = autherLabelTypography.font
        }
        if let currentLenthTypography = style.currentLenthTypography {
            self.podcastCurrentLenth.textColor = currentLenthTypography.color
            self.podcastCurrentLenth.font = currentLenthTypography.font
        }

        if let maxLenthTypography = style.maxLenthTypography {
            self.podcastMaxLenth.textColor = maxLenthTypography.color
            self.podcastMaxLenth.font = maxLenthTypography.font
        }
        self.volumeUpButton.tintColor = style.controlButtonsTintColor ?? .black
        self.volumeDownButton.tintColor = style.controlButtonsTintColor ?? .black
        self.soundSlider.tintColor = style.controlButtonsTintColor ?? .black
        self.progressSlider.tintColor = style.controlButtonsTintColor ?? .black
        self.controlsView.style = .init(buttonsTintColor: style.controlButtonsTintColor ?? .black)
    }

    @objc func didTappedDismissButton() {
        if let window = UIApplication.shared.windows.last(where: { $0.isKeyWindow }) {
            if let tabBarController = window.rootViewController as? MainTabBarController {
                tabBarController.collapsePodcastPlayer()
                collapsedView.alpha = 1
            }
        }
    }

    private func play(url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        playerItemBufferEmptyObserver = player.currentItem?.observe(\AVPlayerItem.isPlaybackBufferEmpty, options: [.new]) { [weak self] _, _ in
            guard let self = self else { return }
            self.podcastMaxLenth.enableSkeleton(enable: true)
        }

        playerItemBufferKeepUpObserver = player.currentItem?.observe(\AVPlayerItem.isPlaybackLikelyToKeepUp, options: [.new]) { [weak self] _, _ in
            guard let self = self else { return }
            self.podcastMaxLenth.enableSkeleton(enable: false)
        }

        playerItemBufferFullObserver = player.currentItem?.observe(\AVPlayerItem.isPlaybackBufferFull, options: [.new]) { [weak self] _, _ in
            guard let self = self else { return }
            self.podcastMaxLenth.enableSkeleton(enable: true)
        }
    }

    @objc func finishedPlaying(_: NSNotification) {
        self.player.seek(to: .zero)
        self.didTappedPlayPauseButton()
    }

    func transformPodcastImageView(toIdentity: Bool = false) {
        let scale = toIdentity ? 1 : self.presentable?.podCastImageAnimationScale ?? 0.8
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.podcastImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }

    private func observePlayerExactPlaying() {
        let time = CMTime(value: 1, timescale: 3)
        let timesArray = [NSValue(time: time)]
        self.player.addBoundaryTimeObserver(forTimes: timesArray, queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
            self.transformPodcastImageView(toIdentity: true)
            self.controlsView.setPlayPauseImage(image: self.presentable?.pauseIcon ?? UIImage(systemName: "pause.fill"))
        }
    }

    private func observeTrackTime() {
        let interval = CMTime(value: 1, timescale: 2)
        self.player.addPeriodicTimeObserver(forInterval: interval, queue: .main,
                                            using: { [weak self] time in
                                                guard let self = self else {
                                                    return
                                                }
                                                self.updateCurrentLenthLabel(currentTime: time.toDisplayableString())
                                                let fullDuration = self.player.currentItem?.duration
                                                self.updateFullLenthLabel(fullTime: fullDuration?.toDisplayableString())
                                                self.updateProgressSlider()
                                            })
    }

    private func updateCurrentLenthLabel(currentTime: String) {
        self.podcastCurrentLenth.text = currentTime
    }

    private func updateFullLenthLabel(fullTime: String?) {
        self.podcastMaxLenth.text = fullTime
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        playerItemBufferEmptyObserver?.invalidate()
        playerItemBufferEmptyObserver = nil
        playerItemBufferKeepUpObserver?.invalidate()
        playerItemBufferKeepUpObserver = nil
        playerItemBufferFullObserver?.invalidate()
        playerItemBufferFullObserver = nil
    }
}

extension PodcastPlayer: PodcastPlayerDataSource {
    func configure(presentable: Presentable) {
        self.collapsedView.alpha = 0
        if self.presentable != nil {
            if self.presentable?.podcastUrl == presentable.podcastUrl {
                return
            }
        }
        self.presentable = presentable
        self.podcastTitleLabel.text = presentable.podCastTitle
        self.collapsedView.podcastTitleLabel.text = presentable.podCastTitle
        self.podcastAuther.text = presentable.podCastAuther
        switch presentable.pocCastImage {
        case let .local(image):
            self.podcastImageView.image = image
            self.collapsedView.podcastImageView.image = image
        case let .url(imageUrl):
            guard let url = URL(string: imageUrl) else {
                return
            }
            let options: KingfisherOptionsInfo = [
                .transition(.fade(0.2)),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ]
            self.podcastImageView.kf.setImage(with: url, options: options)
            self.collapsedView.podcastImageView.kf.setImage(with: url, options: options)
        }
        self.controlsView.setPlayPauseImage(image: presentable.playIcon ?? UIImage(systemName: "play.fill"))
        self.controlsView.setBackwardImage(image: presentable.backwardIcon ?? UIImage(systemName: "gobackward.10"))
        self.controlsView.setForwardImage(image: presentable.forwardIcon ?? UIImage(systemName: "goforward.10"))
        self.podcastCurrentLenth.text = presentable.currentTimeLabelDefaultValue ?? "00.00"
        self.podcastMaxLenth.text = presentable.maxLenghLabelDefaultValue ?? "--:--:--"
        self.transformPodcastImageView()
        self.podcastMaxLenth.enableSkeleton(enable: true)
        self.play(url: presentable.podcastUrl)
        self.soundSlider.value = 1
        self.player.volume = 1
    }
}
