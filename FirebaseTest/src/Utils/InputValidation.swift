//
//  InputValidation.swift
//  FirebaseTest
//
//  Created by 山本裕太 on 2020/01/12.
//  Copyright © 2020 山本裕太. All rights reserved.
//

import Foundation

/**
 * バリデーションエラーProtocol
 */
protocol InvalidStatus: Equatable {}

/**
 * バリデーションエラーenum
 */
enum InvalidUserName: InvalidStatus {
    case empty
    case tooLong(maxCount: Int)
}

/**
 * Validation status for input characters.
 */
enum ValidationStatus<Invalid: InvalidStatus> {
    case valid
    // InvalidStatusの中で実際のバリデーションエラーは定義する
    case invalid(Invalid)
}

/**
 * 実際のバリデーションの型
 */
struct ValidationContainer<Target, Invalid: InvalidStatus> {

    private let target: Target
    private let invalid: Invalid?
   
    /// バリデーションを終了させる
    private func finish() -> ValidationStatus<Invalid> {
        if let invalid = invalid {
            return .invalid(invalid)
        } else {
            return .valid
        }
    }
    
    static func validate(_ target: Target, with validation: (Self) -> Self) -> ValidationStatus<Invalid> {
        let container = Self.init(target: target, invalid: nil)
        let result = validation(container).finish()
        
        return result
    }
    
    func guarantee(_ condition: (Target) -> Bool, otherwise invalidStatus: Invalid) -> Self {
        guard invalid == nil else {
            return self
        }
        if condition(target) == true {
            return self
        } else {
            return ValidationContainer(target: target, invalid: invalidStatus)
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

/**
 * 入力文字数制限
 */
enum ValidationCharacters {
    case userName
    
    var max: Int {
        switch self {
        case .userName:
            return 10
        }
    }

}
