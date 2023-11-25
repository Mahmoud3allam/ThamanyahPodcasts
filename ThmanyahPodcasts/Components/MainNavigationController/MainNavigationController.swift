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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.semanticContentAttribute = LocalizationManager.shared.currentLanguage() == .arabic ? .forceRightToLeft : .forceLeftToRight
        self.navigationBar.semanticContentAttribute = LocalizationManager.shared.currentLanguage() == .arabic ? .forceRightToLeft : .forceLeftToRight
    }
}
