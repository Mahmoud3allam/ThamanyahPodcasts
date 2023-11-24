//
//  PlayListSectionHeaderDataSource.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 24/11/2023.
//

import Foundation

struct PlayListSectionHeaderDataSource {
    var count: Int?
    var totalSeconds: Int?

    func getStringToDisplay() -> String {
        let countIndicator = "Eposide".localize
        let countToDisplay = "\(count ?? 0) \(countIndicator)"
        let duration = convertSecondsToHrMinuteSec(seconds: totalSeconds ?? 0)
        return "\(countToDisplay) , \(duration)"
    }

    func convertSecondsToHrMinuteSec(seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = .full

        let formattedString = formatter.string(from: TimeInterval(seconds))
        return formattedString ?? ""
    }
}
