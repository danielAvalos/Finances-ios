//
//  NibLoadableView.swift
//  Finances
//
//  Created by DESARROLLO on 21/01/21.
//

import UIKit

public protocol NibLoadableView: AnyObject, NibNameIdentifiable {
    func prepareForStoryboardUsage()
}

public extension NibLoadableView where Self: UIView {
    static var nibInstance: Self {
        guard let loadedView = Self.nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("XIB file with identifier: \(identifier) could not be loaded!")
        }

        return loadedView
    }

    var nibViewInstance: UIView {
        guard let view = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("XIB file with identifier: \(Self.identifier) could not be loaded!")
        }

        return view
    }

    func prepareForStoryboardUsage() {
        let view = nibViewInstance

        view.frame = bounds

        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(view)
    }
}
