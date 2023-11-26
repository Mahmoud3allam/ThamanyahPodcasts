//
//  Collection + Safe.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 26/11/2023.
//

import Foundation

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
