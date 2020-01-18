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
 * Validation status for input characters.
 */
enum ValidationStatus<Invalid: InvalidStatus> {
    case valid
    // InvalidStatusの中で実際のバリデーションエラーは定義する
    case invalid(Invalid)
}

/**
 * 実際のバリデーション用Container。Validate配下にextensionでバリデーションパターンを追加できる
 */
struct ValidationContainer<Target, Invalid: InvalidStatus> {

    /// 入力文字
    private let target: Target
    
    /// 有効な入力 → .valud 無効な入力 → .invalid(status:)
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
