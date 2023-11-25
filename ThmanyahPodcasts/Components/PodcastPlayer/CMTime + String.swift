//
//  CMTime + String.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 24/11/2023.
//

import AVKit
import Foundation
extension CMTime {
    func toDisplayableString() -> String {
        let totalAudioSeconds = CMTimeGetSeconds(self)

        // Check if totalAudioSeconds is not NaN and not infinite
        guard !totalAudioSeconds.isNaN, !totalAudioSeconds.isInfinite else {
            return "00:00"
        }

        let seconds = Int(totalAudioSeconds.truncatingRemainder(dividingBy: 60))
        let minutes = Int((totalAudioSeconds.truncatingRemainder(dividingBy: 3600)) / 60)
        let hours = Int(totalAudioSeconds / 3600)

        let timeFormatString: String
        if hours > 0 {
            timeFormatString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            timeFormatString = String(format: "%02d:%02d", minutes, seconds)
        }

        return timeFormatString
    }
}
