//
//  ResetPasswordViewController.swift
//  FirebaseTest
//
//  Created by 山本裕太 on 2020/01/19.
//  Copyright © 2020 山本裕太. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Firebase
import SCLAlertView

/**
 * パスワードリセットモーダル
 */
class ResetPasswordViewController: UIViewController {
    
    // MARK: - Outlets
    
    /// メールアドレス入力欄
    @IBOutlet private weak var emailTextField: UITextField!
    
    /// 戻るボタン
    @IBOutlet private weak var backButton: UIButton!
    
    /// 送信ボタン
    @IBOutlet private weak var sendResetButton: UIButton!
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
    }

}

// MARK: - PrivateFuntions

extension ResetPasswordViewController {
    
    private func subscribe() {
        // 戻るボタン
        backButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true)
        }).disposed(by: rx.disposeBag)
        
        // リセットボタン
        sendResetButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.resetPassoword()
        }).disposed(by: rx.disposeBag)
    }

    /// パスワードをリセットする
    private func resetPassoword() {
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

// MARK: - MakeInstance

extension ResetPasswordViewController {

    static func makeInstance() -> UIViewController {
        guard let vc = R.storyboard.resetPassword.resetPasswordViewController() else {
            return UIViewController()
        }
        return vc
    }

}
