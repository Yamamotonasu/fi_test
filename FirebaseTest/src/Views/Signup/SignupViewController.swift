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
import SCLAlertView

/**
 * ユーザー登録画面
 */
typealias UserNameValidator = ValidationContainer<String, InvalidUserName>
typealias EmailValidator = ValidationContainer<String, InvalidEmail>
typealias PassowrdValidator = ValidationContainer<String, InvalidPassword>

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
    
    /// ユーザーを作成する
    private func createUser() {
        // ユーザー名バリデーション
        let userStatus = validateUserName(userNameTextField.text ?? "")
        switch userStatus {
        case .invalid(let status):
            SCLAlertView().showError("エラー", subTitle: status.message, closeButtonTitle: "確認")
            return
        case .valid:
            break
        }

        // メールアドレスバリデーション
        let emailStatus = validateEmail(emailTextField.text ?? "")
        switch emailStatus {
        case .invalid(let status):
            SCLAlertView().showError("エラー", subTitle: status.message, closeButtonTitle: "確認")
            return
        case .valid:
            break
        }
        
        // パスワードバリデーション
        let passwordStatus = validatePassword(passwordTextField.text ?? "")
        switch passwordStatus {
        case .invalid(let status):
            SCLAlertView().showError("エラー", subTitle: status.message, closeButtonTitle: "確認")
            return
        case .valid:
            break
        }
        
        // パスワードば確認用バリデーション
        guard passwordTextField.text! == confirmPasswordTextField.text! else {
            SCLAlertView().showError("エラー", subTitle: "パスワードと確認用のパスワードが異なります", closeButtonTitle: "確認")
            return
        }

//        let info = CreateUserModel.InputInfomation.init(userName: userName, email: email, password: pass)
//        Auth.auth().createUser(withEmail: <#T##String#>, password: <#T##String#>, completion: <#T##AuthDataResultCallback?##AuthDataResultCallback?##(AuthDataResult?, Error?) -> Void#>)
    }

}

// MARK: - ValidateFunction

extension SignupViewController {
    
    /// userの名前の入力値に対してValidationを掛ける
    private func validateUserName(_ userName: String) -> ValidationStatus<InvalidUserName> {
        UserNameValidator.validate(userName) { $0.isNotEmpty().lessThanDigits()}
    }
    
    /// Emailのバリデーション
    private func validateEmail(_ email: String) -> ValidationStatus<InvalidEmail> {
        EmailValidator.validate(email) { $0.isNotEmpty().validFormat() }
    }
    
    /// パスワードのバリデーション
    private func validatePassword(_ password: String) -> ValidationStatus<InvalidPassword> {
        PassowrdValidator.validate(password) { $0.isNotEmpty().lessThanDigits().greaterThanDigits() }
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
