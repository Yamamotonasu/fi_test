//
//  EmailValidation.swift
//  FirebaseTest
//
//  Created by 山本裕太 on 2020/01/18.
//  Copyright © 2020 山本裕太. All rights reserved.
//

import Foundation

/**
 * メールアドレスのバリデーション用enum
 */
let EMAIL_REGEX = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

enum InvalidEmail: InvalidStatus {
    case empty
    case invalidFormat

    var message: String {
        switch self {
        case .empty:
            return "メールアドレスが入力されていません。"
        case .invalidFormat:
            return "正しいメールアドレスを入力してください。"
        }
    }

}

extension ValidationContainer where Target == String, Invalid == InvalidEmail {

    /// 文字列は空文字ではない
    func isNotEmpty() -> Self {
        return guarantee({ !$0.isEmpty }, otherwise: .empty)
    }

    /// 有効なフォーマットである
    func validFormat() -> Self {
        return guarantee({ text in
            let emailtst = NSPredicate(format: "SELF MATCHES %@", EMAIL_REGEX)
            let result = emailtst.evaluate(with: text)
            return result
        }, otherwise: .invalidFormat)
    }

}
