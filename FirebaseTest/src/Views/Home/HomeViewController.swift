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
        subscribe()
    }

}

// MARK: - PrivateFunction

extension HomeViewController {
    
    private func subscribe() {
        // ログインボタン
        loginLogoutButton.rx.tap.subscribe(onNext: { [weak self] in
            
        }).disposed(by: rx.disposeBag)
    }
}
