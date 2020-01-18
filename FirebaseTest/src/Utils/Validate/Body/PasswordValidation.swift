//
//  PasswordValidation.swift
//  FirebaseTest
//
//  Created by 山本裕太 on 2020/01/18.
//  Copyright © 2020 山本裕太. All rights reserved.
//

import Foundation

/**
 * バリデーションエラーenum
 */
enum InvalidPassword: InvalidStatus {

    case empty
    case tooShort(minCount: Int)
    case tooLong(maxCount: Int)
    
    var message: String {
        switch self {
        case .empty:
            return "パスワードが入力されていません。"
        case .tooShort:
            return "パスワードは\(ValidationCharacters.password.min)文字以上で入力してください。"
        case .tooLong:
            return "パスワードは\(ValidationCharacters.password.max)文字以内で入力してください。"
        }
    }

}

extension ValidationContainer where Target == String, Invalid == InvalidPassword {
    
    /// 文字列は空文字ではない
    func isNotEmpty() -> Self {
        return guarantee({ !$0.isEmpty }, otherwise: .empty)
    }
    
    /// 文字列は最大でmaxDigitsである
    func lessThanDigits() -> Self {
        let maxDigits = ValidationCharacters.password.max
        return guarantee({ $0.count <= maxDigits }, otherwise: .tooLong(maxCount: maxDigits))
    }
    
    /// パスワードの最小はmaxDigitsである
    func greaterThanDigits() -> Self {
        let minDigits = ValidationCharacters.password.min
        return guarantee({ $0.count >= minDigits }, otherwise: .tooShort(minCount: minDigits))
    }

}

