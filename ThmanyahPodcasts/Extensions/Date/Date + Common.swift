//
//  Date + Common.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 25/11/2023.
//

import Foundation

extension Date {
    func toString(format: DateFormatType = .isoDate, timeZone: TimeZoneType = .utc, locale: Locale = Locale.current) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.stringFormat
        formatter.dateStyle = .long
        formatter.timeZone = timeZone.timeZone
        formatter.locale = locale
        return formatter.string(from: self)
    }

    enum DateFormatType {
        /// The ISO8601 formatted year "yyyy" i.e. 1997
        case isoYear

        /// The ISO8601 formatted year and month "yyyy-MM" i.e. 1997-07
        case isoYearMonth

        /// The ISO8601 formatted date "yyyy-MM-dd" i.e. 1997-07-16
        case isoDate

        /// The ISO8601 formatted date and time "yyyy-MM-dd'T'HH:mmZ" i.e. 1997-07-16T19:20+01:00
        case isoDateTime

        /// The ISO8601 formatted date, time and sec "yyyy-MM-dd'T'HH:mm:ssZ" i.e. 1997-07-16T19:20:30+01:00
        case isoDateTimeSec

        /// The ISO8601 formatted date, time and millisec "yyyy-MM-dd'T'HH:mm:ss.SSSZ" i.e. 1997-07-16T19:20:30.45+01:00
        case isoDateTimeMilliSec

        /// The dotNet formatted date "/Date(%d%d)/" i.e. "/Date(1268123281843)/"
        case dotNet

        /// The RSS formatted date "EEE, d MMM yyyy HH:mm:ss ZZZ" i.e. "Fri, 09 Sep 2011 15:26:08 +0200"
        case rss

        /// The Alternative RSS formatted date "d MMM yyyy HH:mm:ss ZZZ" i.e. "09 Sep 2011 15:26:08 +0200"
        case altRSS

        /// The http header formatted date "EEE, dd MM yyyy HH:mm:ss ZZZ" i.e. "Tue, 15 Nov 1994 12:45:26 GMT"
        case httpHeader

        case aRStandard

        /// A generic standard format date i.e. "EEE MMM dd HH:mm:ss Z yyyy"
        case standard

        /// A custom date format string
        case custom(String)

        var stringFormat: String {
            switch self {
            case .isoYear: return "yyyy"
            case .isoYearMonth: return "yyyy-MM"
            case .isoDate: return "yyyy-MM-dd"
            case .isoDateTime: return "yyyy-MM-dd'T'HH:mmZ"
            case .isoDateTimeSec: return "yyyy-MM-dd'T'HH:mm:ssZ"
            case .isoDateTimeMilliSec: return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            case .dotNet: return "/Date(%d%f)/"
            case .rss: return "EEE, d MMM yyyy HH:mm:ss ZZZ"
            case .altRSS: return "d MMM yyyy HH:mm:ss ZZZ"
            case .httpHeader: return "EEE, dd MM yyyy HH:mm:ss ZZZ"
            case .standard: return "EEE MMM dd HH:mm:ss Z yyyy"
            case .aRStandard: return "d MMMM, yyyy"
            case let .custom(customFormat): return customFormat
            }
        }
    }

    enum TimeZoneType {
        case none, defaultValue, local, utc, gmt, identifier(String), abbreviation(String)

        var timeZone: TimeZone? {
            switch self {
            case .none: return nil
            case .defaultValue: return NSTimeZone.default
            case .local: return NSTimeZone.local
            case .utc: return TimeZone(identifier: "UTC")
            case .gmt: return TimeZone(identifier: "GMT")
            case let .identifier(identifierString): return TimeZone(identifier: identifierString)
            case let .abbreviation(abbreviationString): return TimeZone(abbreviation: abbreviationString)
            }
        }
    }
}
