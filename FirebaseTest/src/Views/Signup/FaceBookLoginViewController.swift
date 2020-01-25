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

/**
 * Facebookログイン画面
 */
class FaceBookLoginViewController: UIViewController, LoginButtonDelegate {

    // MARK: - Outlets

    /// メールアドレステキストフィールド
    @IBOutlet private weak var emailTextField: UITextField!

    /// パスワードテキストフィールド
    @IBOutlet private weak var passwordTextField: UITextField!

    /// ログインボタン
    @IBOutlet weak var loginButton: FBLoginButton!

    // MARK: - Properties


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFaceBookLogin()
        subscribe()
    }

}

// MARK: - PrivateFunction

extension FaceBookLoginViewController {

    private func subscribe() {
        loginButton.rx.tap.subscribe(onNext:{ [weak self] in
            self?.facebookLogin()
        }).disposed(by: rx.disposeBag)
    }

    private func setupFaceBookLogin() {

        loginButton.permissions = ["public_profie", "email"]
        loginButton.delegate = self
    }

    private func checkFaceBookLogin() {
    }

    private func facebookLogin() {
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
