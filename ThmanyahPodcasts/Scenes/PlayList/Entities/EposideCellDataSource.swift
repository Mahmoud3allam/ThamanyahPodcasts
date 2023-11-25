//
//  EposideCellDataSource.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 24/11/2023.
//

import Foundation
struct EposideCellDataSource {
    var id: String?
    var imageUrl: String?
    var audioUrl: String?
    var title: String?
    var name: String?
    var date: String?
    var totalSeconts: Int?

    var displayableDateTimeInfo: String {
        return self.dateToDisplay() + " . " + self.durationToDisplay()
    }

    private func dateToDisplay() -> String {
        let date = date?.toDate(format: .isoDateTimeMilliSec)
        let dateToDisplay: String = date?.toString(format: .custom("MM-yyyy"), locale: Locale(identifier: LocalizationManager.shared.currentLanguage().rawValue)) ?? ""
        return dateToDisplay
    }

    private func durationToDisplay() -> String {
        return totalSeconts?.convertSecondsToHrMinutes(style: .full) ?? ""
    }
}
