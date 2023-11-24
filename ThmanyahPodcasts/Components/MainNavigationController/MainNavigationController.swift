//
//  MainNavigationController.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 24/11/2023.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isNavigationBarHidden = true
        interactivePopGestureRecognizer?.delegate = self
        self.interactivePopGestureRecognizer?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.semanticContentAttribute = LocalizationManager.shared.currentLanguage() == .arabic ? .forceRightToLeft : .forceLeftToRight
        self.navigationBar.semanticContentAttribute = LocalizationManager.shared.currentLanguage() == .arabic ? .forceRightToLeft : .forceLeftToRight
    }
}

extension MainNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}
