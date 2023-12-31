//
//  PlayListSectionHeaderDataSource.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 24/11/2023.
//

import Foundation

struct PlayListSectionHeaderDataSource {
    var count: Int?
    var totalSeconds: Int?

    func getStringToDisplay() -> String {
        let countIndicator = "Episode".localize
        let countToDisplay = "\(count ?? 0) \(countIndicator)"
        var durationToDisplay = ""
        if let totalSeconds = self.totalSeconds {
            durationToDisplay = totalSeconds.convertSecondsToHrMinutes()
        }
        return "\(countToDisplay) , \(durationToDisplay)"
    }
}
