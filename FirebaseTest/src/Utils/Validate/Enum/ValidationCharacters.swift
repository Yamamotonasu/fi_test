//
//  ValidationCharacters.swift
//  FirebaseTest
//
//  Created by 山本裕太 on 2020/01/18.
//  Copyright © 2020 山本裕太. All rights reserved.
//

import Foundation

/**
 * 入力文字数制限
 */
enum ValidationCharacters {
    case userName
    case password

    var max: Int {
        switch self {
        case .userName:
            return 10
        case .password:
            return 50
        }
    }

    var min: Int {
        switch self {
        case .userName:
            return 1
        case .password:
            return 8
        }
    }

}
