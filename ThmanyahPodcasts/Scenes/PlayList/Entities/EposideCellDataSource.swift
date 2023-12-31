//
//  EposideCellDataSource.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 24/11/2023.
//

import Foundation
struct EpisodeCellDataSource {
    var id: String?
    var imageUrl: String?
    var audioUrl: String?
    var title: String?
    var name: String?
    var date: String?
    var totalSeconds: Int?

    var displayableDateTimeInfo: String {
        return self.dateToDisplay() + " . " + self.durationToDisplay()
    }

    private func dateToDisplay() -> String {
        let date = date?.toDate(format: .isoDateTimeMilliSec)
        let dateToDisplay: String = date?.toString(format: .custom("MM-yyyy"), locale: Locale(identifier: LocalizationManager.shared.currentLanguage().rawValue)) ?? ""
        return dateToDisplay
    }

    private func durationToDisplay() -> String {
        return totalSeconds?.convertSecondsToHrMinutes(style: .full) ?? ""
    }
}
