//
//  Collection + Safe.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 26/11/2023.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
