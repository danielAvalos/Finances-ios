//
//  LoginViewController.swift
//  Finances
//
//  Created by DESARROLLO on 21/01/21.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet private var logoImageView: UIImageView!
    @IBOutlet private var userEmailInput: InputWithIconView!
    @IBOutlet private var passwordInput: InputWithIconView!
    @IBOutlet private var loginButton: CustomButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        userEmailInput.delegate = self
        passwordInput.delegate = self
    }
}

private extension LoginViewController {

    @IBAction func didTapLoginButton(_: Any) {
        loginButton.startActivityIndicator()
    }
}

extension LoginViewController: InputWithIconViewDelegate {
    func inputTextDidChange(text: String?, inView: InputWithIconView) {
    }
}
