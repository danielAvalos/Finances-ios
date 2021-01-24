//
//  ListViewController+SkeletonTableViewDataSource.swift
//  Finances
//
//  Created by DESARROLLO on 24/01/21.
//

import UIKit
import SkeletonView

extension ListViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        20
    }

    func collectionSkeletonView(_: UITableView, cellIdentifierForRowAt _: IndexPath) -> ReusableCellIdentifier {
        "IndicatorViewCell"
    }
}
