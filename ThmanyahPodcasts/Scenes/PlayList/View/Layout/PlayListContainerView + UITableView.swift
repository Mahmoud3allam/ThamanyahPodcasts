//
//  PlayListContainerView + UITableView.swift
//  ThmanyahPodcasts
//
//  Created by Arab Calibers on 24/11/2023.
//

import Foundation

import UIKit

extension PlayListContainerView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        self.presenter.numberOfEposides()
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(EposidesCell.self), for: indexPath) as? EposidesCell else {
            return UITableViewCell()
        }
        self.presenter.configureEposidesCell(cell: cell, indexPath: indexPath)
        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let view = PlayListSectionHeader()
        if let sectionHeaderData = self.presenter.playListSectionHeaderDataSource {
            view.titleLabel.text = "Eposides".localize
            view.descriptionLabel.text = sectionHeaderData.getStringToDisplay()
        }
        return view
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        85
    }

    func tableView(_: UITableView, didSelectRowAt _: IndexPath) {}

    func tableView(_: UITableView, heightForFooterInSection _: Int) -> CGFloat {
        return 0
    }
}
