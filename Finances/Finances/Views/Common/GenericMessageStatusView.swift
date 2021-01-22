//
//  GenericMessageStatusView.swift
//  Finances
//
//  Created by DESARROLLO on 22/01/21.
//

import UIKit

protocol GenericMessageStatusViewDelegate: AnyObject {
    func didTapAction(action: Message.ButtonItem)
}

class GenericMessageStatusView: UIView, NibLoadableView {

    private var action: Message.ButtonItem?

    // MARK: IBOutlets
    @IBOutlet private weak var topLabel: UILabel!
    @IBOutlet private weak var bottomLabel: UILabel!
    @IBOutlet private weak var actionButton: CustomButton!
    @IBOutlet private weak var gifContainerView: UIView!

    // MARK: Public variables
    weak var delegate: GenericMessageStatusViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gifContainerView.layer.cornerRadius = gifContainerView.frame.height / 2
    }
}

extension GenericMessageStatusView {
    func setup(_ message: Message) {
        action = message.action
        topLabel.text = message.title
        bottomLabel.text = message.description
        if action != nil {
            actionButton.setTitle(message.action?.title.uppercased(), for: .normal)
            actionButton.isHidden = false
        } else {
            actionButton.isHidden = true
        }
    }
}

// MARK: IBActions
private extension GenericMessageStatusView {
    @IBAction func didTapAddCard(_: Any) {
        guard let action = action else {
            return
        }
        delegate?.didTapAction(action: action)
    }
}
