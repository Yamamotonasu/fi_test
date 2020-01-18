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
    
    /// facebookログイン
    @IBOutlet private weak var facebookLoginButton: UIButton!
    
    /// 新しいユーザーを作成ボタン
    @IBOutlet private weak var createNewUserButton: UIButton!

    // MARK: - Properties

    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        subscribe()
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
        
        // facebookログインびボタン
        facebookLoginButton.rx.tap.subscribe(onNext: { [weak self] in
            
        }).disposed(by: rx.disposeBag)
        
        // ユーザー作成ボタン
        createNewUserButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let _self = self else { return }
            let vc = SignupViewController.makeInstance()
            _self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: rx.disposeBag)
        
        // パスワードを忘れたときのボタン
        forgotPasswordButton.rx.tap.subscribe(onNext: { [weak self] in
            
        }).disposed(by: rx.disposeBag)
    }

}

// MARK: - LoginFunctions

extension LoginViewController {
    
    private func loginUser() {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            if let error = error {
                SCLAlertView().showError("", subTitle: error.localizedDescription, closeButtonTitle: "確認")
                return
            }
            SCLAlertView().showSuccess("", subTitle: "ログインしました。")
            self?.dismiss(animated: true)
        }
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
