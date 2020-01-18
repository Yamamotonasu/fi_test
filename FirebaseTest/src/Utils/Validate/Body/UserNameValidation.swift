//
//  UserNameValidation.swift
//  FirebaseTest
//
//  Created by 山本裕太 on 2020/01/18.
//  Copyright © 2020 山本裕太. All rights reserved.
//

import Foundation

/**
 * バリデーションエラーenum
 */
enum InvalidUserName: InvalidStatus {
    case empty
    case tooLong(maxCount: Int)

    var message: String {
        switch self {
        case .empty:
            return "名前が入力されていません。"
        case .tooLong:
            return "名前は\(ValidationCharacters.userName.max)文字以内で入力出来ます。"
        }
    }

}

extension ValidationContainer where Target == String, Invalid == InvalidUserName {

    /// 文字列は空文字ではない
    func isNotEmpty() -> Self {
        return guarantee({ !$0.isEmpty }, otherwise: .empty)
    }

    /// 文字列は最大でmaxDigitsである
    func lessThanDigits() -> Self {
        let maxDigits = ValidationCharacters.userName.max
        return guarantee({ $0.count <= maxDigits }, otherwise: .tooLong(maxCount: maxDigits))
    }

}
