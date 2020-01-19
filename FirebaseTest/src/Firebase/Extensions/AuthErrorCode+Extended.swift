//
//  AuthErrorCode+Extended.swift
//  FirebaseTest
//
//  Created by 山本裕太 on 2020/01/19.
//  Copyright © 2020 山本裕太. All rights reserved.
//

import Foundation
import Firebase

extension AuthErrorCode {

    /// エラーメッセージ
    var errorMessage: String {
        switch self {
        case .emailAlreadyInUse:
            return "そのメールアドレスはもう既に他のアカウントで使用されています。"
        case .userNotFound:
            return "ユーザーが見つかりません。もう一度入力内容をお確かめください。"
        case .userDisabled:
            return "あなたのアカウントは無効になっています。サポートにお問い合わせください。"
        case .invalidEmail, .invalidSender, .invalidRecipientEmail:
            return "正しいメールアドレスを入力してください。"
        case .networkError:
            return "通信に失敗しました。もう一度お試しください。"
        case .weakPassword:
            return "パスワードに脆弱性があります。パスワードは推測されにくいものかつ、6文字以上で入力してください。"
        case .wrongPassword:
            return "入力したパスワードが間違っています。もう一度入力してください。パスワードを忘れた方はパスワードをリセットしてください。"
        default:
            return "申し訳ありません。何かが間違っているようです。"
        }
    }

}
