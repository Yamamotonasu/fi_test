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
//        guard let pass = passwordTextField.text, let passc = confirmPasswordTextField.text else {
//            s
//        }
//        let info = CreateUserModel.InputInfomation.init(userName: userNameTextField.text, email: emailTextField.text, passowrd: passwordTextField.text, passwordConfirm: <#T##String?#>)
//        Auth.auth().createUser(withEmail: <#T##String#>, password: <#T##String#>, completion: <#T##AuthDataResultCallback?##AuthDataResultCallback?##(AuthDataResult?, Error?) -> Void#>)
//    }

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
