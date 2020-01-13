//
//  SignupViewController.swift
//  FirebaseTest
//
//  Created by 山本裕太 on 2020/01/11.
//  Copyright © 2020 山本裕太. All rights reserved.
//

import UIKit
import Firebase
import RxSwift
import RxCocoa

/**
 * ユーザー登録画面
 */
typealias UserNameValidator = ValidationContainer<String, InvalidUserName>
class SignupViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// ユーザー名
    @IBOutlet private weak var userNameTextField: UITextField!
    
    /// メールアドレス
    @IBOutlet private weak var emailTextField: UITextField!
    
    /// パスワード
    @IBOutlet private weak var passwordTextField: UITextField!

    /// パスワード確認
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    
    /// 登録ボタン
    @IBOutlet private weak var registerButton: UIButton!
    
    /// facebookと連携するボタン
    @IBOutlet private weak var linkWithFacebookButton: UIButton!
    
    // MARK: - Properties

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
    }

}

// MARK: - PrivateFunction

extension SignupViewController {
    
    private func subscribe() {
        // 登録ボタン
        registerButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.createUser()
        }).disposed(by: rx.disposeBag)
        
        // facebook連携ボタン
        linkWithFacebookButton.rx.tap.subscribe(onNext: { [weak self] in
            
        }).disposed(by: rx.disposeBag)
    }
    
    private func createUser() {
        let userStatus = validateUserName(userNameTextField.text ?? "")
        switch userStatus {
        case .invalid(let status):
            switch status {
            case .empty:
                // TODO: showAlert
                break
            case .tooLong:
                // TODO: showAlert
                break
            }
        case .valid:
            break
        }

        guard let email = emailTextField.text else {
            // TODO: メールアドレスを入力してください
            return
        }
        
        guard let pass = passwordTextField.text, let passc = confirmPasswordTextField.text else {
            // TODO: パスワードを入力してください。
            return
        }
        
        guard pass == passc else {
            // TODO: パスワードと確認用パスワードが異なります。
            return
        }
//        let info = CreateUserModel.InputInfomation.init(userName: userName, email: email, password: pass)
//        Auth.auth().createUser(withEmail: <#T##String#>, password: <#T##String#>, completion: <#T##AuthDataResultCallback?##AuthDataResultCallback?##(AuthDataResult?, Error?) -> Void#>)
    }

}

// MARK: - ValidateFunction

extension SignupViewController {
    
    private func validateUserName(_ user: String) -> ValidationStatus<InvalidUserName> {
        UserNameValidator.validate(userNameTextField.text!) { $0.isNotEmpty().lessThanDigits()}
    }
}

// MARK: - MakeInstance

extension SignupViewController {
    
    static func makeInstance() -> UIViewController {
        guard let vc = R.storyboard.login.signupViewController() else {
            return UIViewController()
        }
        return vc
    }

}
