//
//  InputWithIconView.swift
//  Finances
//
//  Created by DESARROLLO on 21/01/21.
//

import UIKit

protocol InputWithIconViewDelegate: AnyObject {
    func inputTextDidChange(text: String?, inView: InputWithIconView)
}

@IBDesignable final class InputWithIconView: UIView, NibLoadableView {
    private var hasDoneInitialConfig = false
    weak var delegate: InputWithIconViewDelegate?

    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var textField: UITextField!

    @IBOutlet private var separatorView: UIView!
    private var separatorColor: UIColor = UIColor.color(named: .grayLightColor) ?? .darkGray
    @IBInspectable var placeholder: String? {
        didSet {
            textField.placeholder = placeholder
        }
    }

    @IBInspectable var isSecureEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureEntry
            textField.textContentType = .password
            textField.keyboardType = .default
        }
    }

    @IBInspectable var inactiveIcon: UIImage? {
        didSet {
            inactiveIcon = inactiveIcon?.withRenderingMode(.alwaysTemplate)
        }
    }

    @IBInspectable var activeIcon: UIImage? {
        didSet {
            activeIcon = activeIcon?.withRenderingMode(.alwaysTemplate)
        }
    }

    @IBInspectable var placeHolderColor: UIColor = UIColor.white.withAlphaComponent(0.5) {
        didSet {
            checkUIStatus()
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
        textField.textColor = separatorColor
        separatorView.backgroundColor = textField.text?.isEmpty == true ? separatorColor.withAlphaComponent(0.5) : separatorColor
        iconImageView.image = textField.text?.isEmpty == true ? inactiveIcon : activeIcon
        iconImageView.tintColor = separatorColor
    }

    private func initialConfig() {
        checkUIStatus()
        guard let currentPlaceholder = self.textField.placeholder else {
            return
        }
        let placeholderAttributes = [NSAttributedString.Key.foregroundColor: placeHolderColor, .font: UIFont.systemFont(ofSize: 15)]
        textField.attributedPlaceholder = NSAttributedString(string: currentPlaceholder,
                                                             attributes: placeholderAttributes)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if !hasDoneInitialConfig {
            initialConfig()
            hasDoneInitialConfig = true
        }
    }
}

// MARK: Public functions
extension InputWithIconView {
    func separatorViewColor(color: UIColor) {
        separatorColor = color
        checkUIStatus()
    }
}

extension InputWithIconView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_: UITextField) {}

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction private func textDidChange(_: Any) {
        checkUIStatus()
        delegate?.inputTextDidChange(text: textField.text, inView: self)
    }
}
