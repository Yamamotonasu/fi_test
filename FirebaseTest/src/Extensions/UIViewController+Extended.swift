//
//  UIViewController+Extended.swift
//  FirebaseTest
//
//  Created by 山本裕太 on 2020/01/11.
//  Copyright © 2020 山本裕太. All rights reserved.
//

import Foundation
import UIKit
import NSObject_Rx
import SCLAlertView
import Firebase

extension UIViewController {

    /**
     * error内容に応じたアラートを表示する
     */
    func handleFireAuthError(_ error: Error) {
        // error._codeでエラーコードの番号を調べる事が出来る
        if let errorCode = AuthErrorCode(rawValue: error._code) {
            SCLAlertView().showError("", subTitle: errorCode.errorMessage, closeButtonTitle: "確認")
        }
    }

}
