//
//  DetailInteractorFieldView.swift
//  Finances
//
//  Created by DESARROLLO on 24/01/21.
//

import UIKit

@IBDesignable final class DetailIndicatorFieldView: UIView, NibLoadableView {
    private var hasDoneInitialConfig = false

    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var valueLabel: UILabel!

    private var textColor: UIColor = UIColor.color(named: .black) ?? .darkGray

    @IBInspectable var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    @IBInspectable var icon: UIImage? {
        didSet {
            icon = icon?.withRenderingMode(.alwaysTemplate)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareForStoryboardUsage()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareForStoryboardUsage()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }

    private func checkUIStatus() {
        titleLabel.textColor = textColor
        valueLabel.textColor = textColor
        iconImageView.image = icon
        iconImageView.tintColor = textColor
    }

    private func initialConfig() {
        checkUIStatus()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if !hasDoneInitialConfig {
            initialConfig()
            hasDoneInitialConfig = true
        }
    }
}

extension DetailIndicatorFieldView {
    func setValue(value: String?) {
        self.isHidden = true
        if let value = value {
            valueLabel.text = value
        }
        let currentBound = self.bounds
        UIView.transition(with: self, duration: 0.8,
                          options: [.transitionFlipFromRight,
                                    .allowAnimatedContent,
                                    .beginFromCurrentState],
          animations: {
            self.frame = CGRect(x: currentBound.origin.x + UIScreen.main.bounds.width,
                                y: currentBound.origin.y ,
                                width: currentBound.width,
                                height: currentBound.height)
            self.isHidden = false
          },
          completion: { _ in
            self.frame = CGRect(x: currentBound.origin.x,
                                y: currentBound.origin.y,
                                width: currentBound.width,
                                height: currentBound.height)
          }
        )
    }
}
