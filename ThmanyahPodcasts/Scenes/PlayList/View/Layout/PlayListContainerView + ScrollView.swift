//
//  PlayListContainerView + ScrollView.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 24/11/2023.
//

import Foundation
import UIKit

extension PlayListContainerView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.headerView.scrollViewDidScroll(scrollView: scrollView)
    }
}
