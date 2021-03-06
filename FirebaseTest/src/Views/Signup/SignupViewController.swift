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

    private var isEqualPassword: Bool {
        return passwordTextField.text == confirmPasswordTextField.text
    }

    /// パスワードが一致している→ true パスワードが一致していない→false
    private let passwordCheckRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)

    /// パスワードチェック用Driver
    private var passwordCheckDriver: Driver<Bool> {
        return passwordCheckRelay.asDriver()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
        setupUI()
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

        // パスワード入力監視
        passwordTextField.rx.text.subscribe(onNext: { [weak self] _ in
            self?.passwordCheckRelay.accept(self?.isEqualPassword ?? false)
        }).disposed(by: rx.disposeBag)

        // パスワード確認入力監視
        confirmPasswordTextField.rx.text.subscribe(onNext: { [weak self] _ in
            self?.passwordCheckRelay.accept(self?.isEqualPassword ?? false)
        }).disposed(by: rx.disposeBag)

        // パスワードと確認が同じかどうかの処理
        passwordCheckDriver.drive(onNext: { [weak self] in
            self?.passwordTextField.textColor = $0 ? UIColor.black : UIColor.red
            self?.confirmPasswordTextField.textColor = $0 ? UIColor.black : UIColor.red
            self?.registerButton.isEnabled = $0
        }).disposed(by: rx.disposeBag)
    }

    private func setupUI() {
        passwordTextField.rightViewMode = .always
    }

    /// ユーザーを作成する
    private func createUser() {
        // ユーザー名バリデーション
        let userName = userNameTextField.text ?? ""
        let userStatus = validateUserName(userName)
        switch userStatus {
        case .invalid(let status):
            SCLAlertView().showError("エラー", subTitle: status.message, closeButtonTitle: "確認")
            return
        case .valid:
            break
        }

        // メールアドレスバリデーション
        let email = emailTextField.text ?? ""
        let emailStatus = validateEmail(email)
        switch emailStatus {
        case .invalid(let status):
            SCLAlertView().showError("エラー", subTitle: status.message, closeButtonTitle: "確認")
            return
        case .valid:
            break
        }

        // パスワードバリデーション
        let password = passwordTextField.text ?? ""
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

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                self?.handleFireAuthError(error)
                debugPrint(error.localizedDescription)
                return
            }
            guard let _ = result?.user else {
                SCLAlertView().showError("エラー", subTitle: "ユーザーの作成に失敗しました。", closeButtonTitle: "確認")
                return
            }

            let credential = EmailAuthProvider.credential(withEmail: email, password: password)

            guard let _ = Auth.auth().currentUser else { return }

            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    SCLAlertView().showError("エラー", subTitle: error.localizedDescription, closeButtonTitle: "確認")
                }
                self?.navigationController?.popViewController(animated: true)
            }
            SCLAlertView().showSuccess("", subTitle: "ユーザーを作成しました。", closeButtonTitle: "確認", animationStyle: .leftToRight)
        }

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
