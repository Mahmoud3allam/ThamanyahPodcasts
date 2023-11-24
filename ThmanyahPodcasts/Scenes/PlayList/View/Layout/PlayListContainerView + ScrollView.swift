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

    enum ScrollDirection {
        case up, down
    }

    var scrollDirection: ScrollDirection? {
        if tableView.panGestureRecognizer.translation(in: tableView.superview).y > 0 {
            return .up
        } else if tableView.panGestureRecognizer.translation(in: tableView.superview).y < 0 {
            return .down
        } else {
            return nil
        }
    }
}
