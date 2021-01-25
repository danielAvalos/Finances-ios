//
//  LoginViewController.swift
//  Finances
//
//  Created by DESARROLLO on 21/01/21.
//

import UIKit

final class LoginViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var userEmailInput: InputWithIconView!
    @IBOutlet private weak var passwordInput: InputWithIconView!
    @IBOutlet private weak var loginButton: CustomButton!

    var viewModel: (LoginViewModelProtocol & LoginViewModelEntityProtocol)?
    var coordinator: LoginCoordinatorProtocol?

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        userEmailInput.delegate = self
        passwordInput.delegate = self
    }
}

// MARK: - Private functions
private extension LoginViewController {

    func setup() {
        LoginConfigurator.configure(self)
    }

    @IBAction func didTapLoginButton(_: Any) {
        loginButton.startActivityIndicator()
        viewModel?.login()
    }
}

// MARK: - InputWithIconViewDelegate
extension LoginViewController: InputWithIconViewDelegate {
    func inputTextDidChange(text: String?, inView: InputWithIconView) {
        if inView == userEmailInput {
            viewModel?.userName = text
        } else {
            viewModel?.password = text
        }
    }
}

// MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate {

    func loginDidComplete() {
        DispatchQueue.main.async { [weak self] in
            self?.coordinator?.navigateToList()
        }
    }

    func loginDidFailWithError(_ error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.showAlert(title: error.title, message: error.description)
            self?.loginButton.stopActivityIndicator()
        }
    }
}
