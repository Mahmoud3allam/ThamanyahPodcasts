//
//  PlayListContainerView + UITableView.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 24/11/2023.
//

import Foundation

import UIKit

extension PlayListContainerView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        self.presenter.numberOfEpisodes()
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(EpisodesCell.self), for: indexPath) as? EpisodesCell else {
            return UITableViewCell()
        }
        self.presenter.configureEpisodesCell(cell: cell, indexPath: indexPath)
        cell.onTapPlay = { [weak self] in
            guard let self = self else {
                return
            }
            self.presenter.playEpisode(at: indexPath)
        }
        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let view = PlayListSectionHeader()
        if let sectionHeaderData = self.presenter.playListSectionHeaderDataSource {
            view.titleLabel.text = "Episodes".localize
            view.descriptionLabel.text = sectionHeaderData.getStringToDisplay()
        }
        return view
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        85
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.playEpisode(at: indexPath)
    }

    func tableView(_: UITableView, viewForFooterInSection _: Int) -> UIView? {
        return nil
    }

    func tableView(_: UITableView, heightForFooterInSection _: Int) -> CGFloat {
        return 0
    }
}
