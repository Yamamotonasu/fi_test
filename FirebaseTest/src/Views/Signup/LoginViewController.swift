//
//  LoginViewController.swift
//  FirebaseTest
//
//  Created by 山本裕太 on 2020/01/09.
//  Copyright © 2020 山本裕太. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxCocoa
import Firebase
import SCLAlertView
import FBSDKLoginKit

/**
 * ログイン画面
 */
class LoginViewController: UIViewController {

    // MARK: - Outlets

    /// メールアドレス
    @IBOutlet private weak var emailTextField: UITextField!

    /// パスワード
    @IBOutlet private weak var passwordTextField: UITextField!

    /// パスワードを忘れたとき
    @IBOutlet private weak var forgotPasswordButton: UIButton!

    /// ログインボタン
    @IBOutlet private weak var loginButton: UIButton!

    /// Facebookログイン用View
    @IBOutlet weak var faceBookLoginButtonView: UIView!

    /// 新しいユーザーを作成ボタン
    @IBOutlet private weak var createNewUserButton: UIButton!

    /// 戻るボタン
    @IBOutlet private weak var backButton: RoundedButton!


    // MARK: - Properties

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        checkFaceBookLogined()
        setupUI()
        subscribe()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

// MARK: - PrivateFunction

extension LoginViewController {

    private func setupUI() {
        navigationController?.navigationBar.barTintColor = FS_RED
    }

    private func subscribe() {
        // ログインボタン
        loginButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.loginUser()
        }).disposed(by: rx.disposeBag)

        // ユーザー作成ボタン
        createNewUserButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let _self = self else { return }
            let vc = SignupViewController.makeInstance()
            _self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: rx.disposeBag)

        // パスワードを忘れたときのボタン
        forgotPasswordButton.rx.tap.subscribe(onNext: { [weak self] in
            let vc = ResetPasswordViewController.makeInstance()
            self?.present(vc, animated: true)
        }).disposed(by: rx.disposeBag)

        // 戻るボタン
        backButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: rx.disposeBag)
    }

}

// MARK: - LoginFunctions

extension LoginViewController {

    /// ログインする
    private func loginUser() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (_, error) in
            if let error = error {
                self?.handleFireAuthError(error)
                return
            }
            SCLAlertView().showSuccess("", subTitle: "ログインしました。")
            self?.dismiss(animated: true)
        }
    }
    
    /// パスワードをリセットする
    private func forgotPassword() {
        guard let email = emailTextField.text else { return }
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                SCLAlertView().showError("", subTitle: error.localizedDescription, closeButtonTitle: "確認")
                return
            }
            SCLAlertView().showSuccess("", subTitle: "パスワードをリセットしました。", closeButtonTitle: "確認")
        }
    }

}

// MARK: - Facebook login function

extension LoginViewController: LoginButtonDelegate {

    /// Facebookログインボタンの設定
    private func setupFaceBookLogin() {
        let faceBookLoginButton = FBLoginButton()
        faceBookLoginButton.permissions = ["public_profile", "email"]
        faceBookLoginButton.backgroundColor = UIColor.clear
        faceBookLoginButton.frame = CGRect(x: 0, y: 0, width: loginButton.frame.width, height: loginButton.frame.height)
        let newCenter = CGPoint(x: faceBookLoginButtonView.frame.width / 2, y: faceBookLoginButtonView.frame.height / 2)
        faceBookLoginButton.center = newCenter
        faceBookLoginButton.delegate = self
        faceBookLoginButtonView.addSubview(faceBookLoginButton)
    }

    private func checkFaceBookLogined() {
        // ログイン済みかどうかチェックする
        if let token = AccessToken.current {
            let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
            Auth.auth().signIn(with: credential) { (result, error) in
                if let error = error {
                    self.handleFireAuthError(error)
                    return
                }
                return
            }
        }
        // 未ログインだった場合はFaceBookログインの処理を行う
        setupFaceBookLogin()
    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        // ログアウトの処理
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            self.handleFireAuthError(signOutError)
        }
    }

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            self.handleFireAuthError(error)
            return
        }

        if let token = AccessToken.current {
            let credential = FacebookAuthProvider.credential(withAccessToken: token.tokenString)
            Auth.auth().signIn(with: credential) { (result, error) in
                if let error = error {
                    self.handleFireAuthError(error)
                    return
                }
                print("FaceBookLogin successful!!")
                // ログイン後の処理
            }
        }

        // tokenを取得出来なかった時の処理
    }

}

// MARK: - MakeInstance

extension LoginViewController {

    static func makeInstance() -> UIViewController {
        guard let vc = R.storyboard.login.loginViewController() else {
            return UIViewController()
        }
        return vc
    }

}
