//
//  String + Date.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 25/11/2023.
//

import Foundation
extension String {
    // MARK: - Convert from string

    func toDate(format: Date.DateFormatType = .isoDate, timeZone: Date.TimeZoneType = .utc, locale: Locale = Locale.current) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.stringFormat
        formatter.timeZone = timeZone.timeZone
        formatter.locale = locale
        return formatter.date(from: self)
    }
}
