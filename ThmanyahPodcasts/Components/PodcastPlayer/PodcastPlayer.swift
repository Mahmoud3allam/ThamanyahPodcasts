//
//  PodcastPlayer.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 24/11/2023.
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

    lazy var dismissButton: UIButton = {
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

    var lenthLabelsStackView: UIStackView = {
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

    lazy var controlsView: PlayerControlsView = {
        var view = PlayerControlsView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
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
        self.observePlayerWhenPlaying()
        self.setupTrackTimeObserver()
        self.addTapGesture()
        self.addPanGestures()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layoutUserInterFace() {
        addSubViews()
        setupContainerViewConstraints()
        setupDismissButtonConstraints()
        setupPodcastImageViewConstraints()
        setupProgressSliderConstraints()
        setupLenthLabelsStackViewConstraints()
        setupPodcastTitleLabelConstraints()
        setupPodcastAutherLabelConstraints()
        setupControlsContainerViewConstraints()
        setupControlsViewConstraints()
        setupSoundSliderConstraints()
        setupVolumeUpButtonConstraints()
        setupVolumeDownButtonConstraints()
        setupCollapsedViewConstraints()
    }

    private func addSubViews() {
        self.addSubview(self.containerView)
        self.containerView.addSubview(dismissButton)
        self.containerView.addSubview(podcastImageView)
        self.containerView.addSubview(progressSlider)
        self.containerView.addSubview(lenthLabelsStackView)
        self.containerView.addSubview(podcastTitleLabel)
        self.containerView.addSubview(podcastAuther)
        self.containerView.addSubview(controlsViewContainer)
        self.containerView.addSubview(controlsView)
        self.containerView.addSubview(soundSlider)
        self.containerView.addSubview(volumeUpButton)
        self.containerView.addSubview(volumeDownButton)
        self.addSubview(collapsedView)
    }

    // MARK: Setup Player Style

    private func updateStyle(style: PodcastPlayerStyle) {
        updateBackgroundColor(style)
        updateDismissButton(style)
        updatePodcastImageView(style)
        updateLabelsTypography(style)
        updateControlButtons(style)
    }

    private func updateBackgroundColor(_ style: PodcastPlayerStyle) {
        containerView.backgroundColor = style.backgroundColor
        collapsedView.backgroundColor = style.minimizedViewBackground ?? style.backgroundColor
    }

    private func updateDismissButton(_ style: PodcastPlayerStyle) {
        if let dismissButtonTypography = style.dismissButtonTypography {
            dismissButton.titleLabel?.font = dismissButtonTypography.font
            dismissButton.titleLabel?.textColor = dismissButtonTypography.color
            dismissButton.tintColor = dismissButtonTypography.color
        }
    }

    private func updatePodcastImageView(_ style: PodcastPlayerStyle) {
        podcastImageView.contentMode = style.podcastImageContentMode ?? .scaleAspectFill
    }

    private func updateLabelsTypography(_ style: PodcastPlayerStyle) {
        updateLabelTypography(podcastTitleLabel, style.titleLabelTypography)
        updateLabelTypography(podcastAuther, style.autherLabelTypography)
        updateLabelTypography(podcastCurrentLenth, style.currentLenthTypography)
        updateLabelTypography(podcastMaxLenth, style.maxLenthTypography)
    }

    private func updateLabelTypography(_ label: UILabel, _ typography: Typography?) {
        if let labelTypography = typography {
            label.textColor = labelTypography.color
            label.font = labelTypography.font
        }
    }

    private func updateControlButtons(_ style: PodcastPlayerStyle) {
        let buttonsTintColor = style.controlButtonsTintColor ?? .black
        volumeUpButton.tintColor = buttonsTintColor
        volumeDownButton.tintColor = buttonsTintColor
        soundSlider.tintColor = buttonsTintColor
        progressSlider.tintColor = buttonsTintColor
        controlsView.style = PlayerControlsViewStyle(buttonsTintColor: buttonsTintColor)
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
        self.observeTrackEnding()
        self.observePlayerBuffringState()
    }

    func applyPodcastImageTransform(toIdentity: Bool = false) {
        let scale = toIdentity ? 1 : self.presentable?.podCastImageAnimationScale ?? 0.8
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.podcastImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }

    private func updateCurrentLenthLabel(currentTime: String) {
        self.podcastCurrentLenth.text = currentTime
    }

    private func updateFullLenthLabel(fullTime: String?) {
        self.podcastMaxLenth.text = fullTime
    }

    deinit {
        self.removeObservers()
    }
}

// MARK: Configure View And Play

extension PodcastPlayer: PodcastPlayerDataSource {
    func configure(presentable: Presentable) {
        self.collapsedView.alpha = 0
        if self.presentable != nil {
            if self.presentable?.podcastId == presentable.podcastId {
                return
            }
        }
        self.presentable = presentable
        self.configurePlayerLabels(presentable: presentable)
        self.configureImageView(presentable: presentable)
        self.configureControlsView(presentable: presentable)
        self.configureLoadingState(isLoading: true)
        self.preparePlayerVolumeSettings()
        self.play(url: presentable.podcastUrl)
    }

    private func configurePlayerLabels(presentable: Presentable) {
        self.podcastTitleLabel.text = presentable.podCastTitle
        self.collapsedView.podcastTitleLabel.text = presentable.podCastTitle
        self.podcastAuther.text = presentable.podCastAuther
        self.podcastCurrentLenth.text = presentable.currentTimeLabelDefaultValue ?? "00.00"
        self.podcastMaxLenth.text = presentable.maxLenghLabelDefaultValue ?? "--:--:--"
    }

    private func configureImageView(presentable: Presentable) {
        switch presentable.pocCastImage {
        case let .local(image):
            self.podcastImageView.image = image
            self.collapsedView.podcastImageView.image = image
        case let .url(imageUrl):
            self.collapsedView.podcastImageView.setImage(from: imageUrl)
            self.podcastImageView.setImage(from: imageUrl)
        }
        self.applyPodcastImageTransform()
    }

    private func configureControlsView(presentable: Presentable) {
        self.controlsView.setPlayPauseImage(image: presentable.playIcon ?? UIImage(systemName: "play.fill"))
        self.controlsView.setBackwardImage(image: presentable.backwardIcon ?? UIImage(systemName: "gobackward.10"))
        self.controlsView.setForwardImage(image: presentable.forwardIcon ?? UIImage(systemName: "goforward.10"))
    }

    func configureLoadingState(isLoading: Bool) {
        self.podcastMaxLenth.enableSkeleton(enable: isLoading)
    }

    private func preparePlayerVolumeSettings() {
        self.soundSlider.value = 1
        self.player.volume = 1
    }
}

// MARK: Observers

extension PodcastPlayer {
    private func observePlayerWhenPlaying() {
        let time = CMTime(value: 1, timescale: 3)
        let timesArray = [NSValue(time: time)]
        self.player.addBoundaryTimeObserver(forTimes: timesArray, queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
            self.applyPodcastImageTransform(toIdentity: true)
            self.controlsView.setPlayPauseImage(image: self.presentable?.pauseIcon ?? UIImage(systemName: "pause.fill"))
        }
    }

    private func setupTrackTimeObserver() {
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

    private func observePlayerBuffringState() {
        playerItemBufferEmptyObserver = player.currentItem?.observe(\AVPlayerItem.isPlaybackBufferEmpty, options: [.new]) { [weak self] _, _ in
            guard let self = self else {
                return
            }
            self.configureLoadingState(isLoading: true)
        }

        playerItemBufferKeepUpObserver = player.currentItem?.observe(\AVPlayerItem.isPlaybackLikelyToKeepUp, options: [.new]) { [weak self] _, _ in
            guard let self = self else {
                return
            }
            self.configureLoadingState(isLoading: false)
        }

        playerItemBufferFullObserver = player.currentItem?.observe(\AVPlayerItem.isPlaybackBufferFull, options: [.new]) { [weak self] _, _ in
            guard let self = self else {
                return
            }
            self.configureLoadingState(isLoading: true)
        }
    }

    private func observeTrackEnding() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player.currentItem)
    }

    @objc func finishedPlaying(_: NSNotification) {
        self.player.seek(to: .zero)
        self.didTappedPlayPauseButton()
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        playerItemBufferEmptyObserver?.invalidate()
        playerItemBufferEmptyObserver = nil
        playerItemBufferKeepUpObserver?.invalidate()
        playerItemBufferKeepUpObserver = nil
        playerItemBufferFullObserver?.invalidate()
        playerItemBufferFullObserver = nil
    }
}
