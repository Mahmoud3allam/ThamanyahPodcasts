//
//  Int + TimeInterval.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 25/11/2023.
//

import Foundation
extension Int {
    func convertSecondsToHrMinutes(style: DateComponentsFormatter.UnitsStyle = .full) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = style
        let formattedString = formatter.string(from: TimeInterval(self))
        return formattedString ?? ""
    }
}
