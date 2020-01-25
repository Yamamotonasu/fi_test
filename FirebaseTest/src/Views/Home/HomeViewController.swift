//
//  HomeViewController.swift
//  FirebaseTest
//
//  Created by 山本裕太 on 2020/01/11.
//  Copyright © 2020 山本裕太. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Firebase

/**
 * ホーム画面のViewController
 */
class HomeViewController: UIViewController {

    // MARK: - Outlets

    /// ログイン/ログアウトボタン
    @IBOutlet private weak var loginLogoutButton: UIButton!

    // MARK: - Properties

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser == nil {
            // 匿名ログイン
            Auth.auth().signInAnonymously { (result, error) in
                if let error = error {
                    self.handleFireAuthError(error)
                } else {
                    print(Auth.auth().currentUser?.uid ?? "***")
                }
            }
        }
        subscribe()
    }

}

// MARK: - PrivateFunction

extension HomeViewController {

    private func subscribe() {
        // ログインボタン
        loginLogoutButton.rx.tap.subscribe(onNext: { [weak self] in
            // 匿名でログインしている場合はログアウトされない
            if !(Auth.auth().currentUser?.isAnonymous ?? false) {
                try! Auth.auth().signOut()
            }
            let vc = LoginViewController.makeInstance()
            self?.present(vc, animated: true)
        }).disposed(by: rx.disposeBag)
    }
}

// MARK: - MakeInstance

extension HomeViewController {

    static func makeInstance() -> UIViewController {
        guard let vc = R.storyboard.main.homeViewController() else {
            return UIViewController()
        }
        return vc
    }

}
