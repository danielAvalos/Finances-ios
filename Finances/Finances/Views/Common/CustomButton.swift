//
//  CustomButton.swift
//  Finances
//
//  Created by DESARROLLO on 21/01/21.
//

import UIKit

@IBDesignable class CustomButton: UIButton {
    private var dottedLayer: CAShapeLayer?
    private var activityIndicator: UIActivityIndicatorView?
    private(set) var isAnimating = false

    @IBInspectable var cornerRadius: CGFloat = 25 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable var dottedBorderColor: UIColor? = nil {
        didSet {
            addDottedBorder()
        }
    }

    @IBInspectable var activityIndicatorColor: UIColor? = UIColor.color(named: .white) {
        didSet {
            createActivityIndicator()
        }
    }

    @IBInspectable var icon: UIImage? {
        didSet {
            self.setImage(icon, for: .normal)
            self.contentHorizontalAlignment = .center
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }

    override func prepareForInterfaceBuilder() {
        sharedInit()
    }

    private func sharedInit() {
        layer.cornerRadius = cornerRadius
    }

    private func addDottedBorder() {
        if dottedLayer != nil {
            dottedLayer?.removeFromSuperlayer()
            dottedLayer = nil
        }
        guard let borderColor = dottedBorderColor else { return }
        dottedLayer = CAShapeLayer()
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        dottedLayer?.path = path.cgPath
        dottedLayer?.strokeColor = borderColor.cgColor
        dottedLayer?.lineDashPattern = [3, 3]
        dottedLayer?.lineWidth = 2
        dottedLayer?.backgroundColor = UIColor.clear.cgColor
        dottedLayer?.fillColor = UIColor.clear.cgColor
        // swiftlint:disable force_unwrapping
        layer.addSublayer(dottedLayer!)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        addDottedBorder()
    }

    // MARK: - Activity indicator

    func startActivityIndicator(animated: Bool = true) {
        createActivityIndicator()

        isUserInteractionEnabled = false
        activityIndicator?.startAnimating()
        isAnimating = true

        UIView.animate(withDuration: animated ? 0.2 : 0, animations: {
            self.activityIndicator?.alpha = 1
            self.titleLabel?.alpha = 0
            self.setImage(nil, for: .normal)
        }, completion: nil)
    }

    func stopActivityIndicator(animated: Bool = true) {
        isUserInteractionEnabled = true
        activityIndicator?.stopAnimating()
        isAnimating = false

        UIView.animate(withDuration: animated ? 0.2 : 0, animations: {
            self.activityIndicator?.alpha = 0
            self.titleLabel?.alpha = 1
            self.setImage(self.icon, for: .normal)
        }, completion: nil)
    }

    private func createActivityIndicator() {
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView()
            if let indicator = activityIndicator {
                addSubview(indicator)

                indicator.translatesAutoresizingMaskIntoConstraints = false

                indicator.alpha = 0

                indicator.hidesWhenStopped = false

                addConstraint(NSLayoutConstraint(item: indicator,
                                                 attribute: .centerX,
                                                 relatedBy: .equal,
                                                 toItem: self,
                                                 attribute: .centerX,
                                                 multiplier: 1,
                                                 constant: 0))

                addConstraint(NSLayoutConstraint(item: indicator,
                                                 attribute: .centerY,
                                                 relatedBy: .equal,
                                                 toItem: self,
                                                 attribute: .centerY,
                                                 multiplier: 1,
                                                 constant: 0))
                layoutIfNeeded()
            }
        }

        activityIndicator?.style = .medium
        activityIndicator?.color = activityIndicatorColor
    }
}
