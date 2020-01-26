//
//  FaceBookLoginViewController.swift
//  FirebaseTest
//
//  Created by 山本裕太 on 2020/01/25.
//  Copyright © 2020 山本裕太. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import FBSDKLoginKit
import SCLAlertView

/**
 * Facebookログイン画面(pending)
 */
class FaceBookLoginViewController: UIViewController {


    // MARK: - Outlets

    /// メールアドレステキストフィールド
    @IBOutlet private weak var emailTextField: UITextField!

    /// パスワードテキストフィールド
    @IBOutlet private weak var passwordTextField: UITextField!

    /// ログインボタン
    @IBOutlet private weak var loginButton: UIButton!

    /// facebookログイン用ボタンビュー
    @IBOutlet private weak var faceBookLoginButtonView: UIView!

    // MARK: - Properties


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFaceBookLogin()
        subscribe()
    }

}

// MARK: - PrivateFunction

extension FaceBookLoginViewController: LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        //
    }


    private func subscribe() {
//        loginButton.rx.tap.subscribe(onNext:{ [weak self] in
//
//        }).disposed(by: rx.disposeBag)
    }

    private func setupFaceBookLogin() {
        let loginButton = FBLoginButton()
        loginButton.permissions = ["public_profile", "email"]
        loginButton.delegate = self
        faceBookLoginButtonView.allPin(subView: loginButton)
        faceBookLoginButtonView.addSubview(loginButton)
    }

    private func checkFaceBookLogin() {
    }

    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            SCLAlertView().showError("", subTitle: error.localizedDescription, closeButtonTitle: "確認")
        }
    }
}

// MARK: - MakeInstance

extension FaceBookLoginViewController {

    static func makeInstance() -> UIViewController {
        guard let vc = R.storyboard.login.faceBookLoginViewController() else {
            return UIViewController()
        }
        return vc
    }

}
