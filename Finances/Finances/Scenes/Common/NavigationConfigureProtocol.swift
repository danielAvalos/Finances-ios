//
//  NavigationConfigureProtocol.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit

@objc protocol NavigationConfigureProtocol {
    func didTapBarItem(sender: UIBarButtonItem)
}

extension NavigationConfigureProtocol where Self: UIViewController {
    func showActivityIndicator() {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.startAnimating()
        let activityIndicatorBarButtonItem = UIBarButtonItem(customView: activityIndicatorView)
        navigationItem.rightBarButtonItem = activityIndicatorBarButtonItem
    }

    func showBarButtonItem(navigationItem: UINavigationItem, items: [BarButtonItemTag]) {
        let items = getBarButtonItem(items: items)
        navigationItem.rightBarButtonItems = nil
        navigationItem.rightBarButtonItems = items
    }

    private func getBarButtonItem(items: [BarButtonItemTag]) -> [UIBarButtonItem]? {
        var barButtonItems: [UIBarButtonItem] = [UIBarButtonItem]()
        for item in items {
            switch item {
            case .logout:
                let image = UIImage(systemName: "power")?.withTintColor(UIColor.color(named: .green) ?? .green, renderingMode: .alwaysTemplate)
                let item = UIBarButtonItem(image: image,
                                           style: .done,
                                           target: self,
                                           action: #selector(didTapBarItem))
                item.tintColor = UIColor.color(named: .green)
                item.tag = item.tag
                item.width = 20.0
                barButtonItems.append(item)
            }
        }
        return barButtonItems
    }
}
