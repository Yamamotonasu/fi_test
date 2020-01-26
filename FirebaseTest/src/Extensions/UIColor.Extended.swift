//
//  UIColor.Extended.swift
//  FirebaseTest
//
//  Created by 山本裕太 on 2020/01/26.
//  Copyright © 2020 山本裕太. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {

    class func hexStr (hexStr: NSString, alpha: CGFloat) -> UIColor {
        let alpha = alpha
        var hexStr = hexStr
        hexStr = hexStr.replacingOccurrences(of: "#", with: "") as NSString
        let scanner = Scanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        } else {
            print("invalid hex string")
            return UIColor.white
        }
    }

    // メインカラー
    class func keyColor(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor.hexStr(hexStr: "#F0ADD4", alpha: alpha)
    }

    // サブカラー
    class func lightBlue() -> UIColor {
        return UIColor.hexStr(hexStr: "#A6F8DB", alpha: 1.0)
    }

    // サブカラー
    class func deepBlue() -> UIColor {
        return UIColor.hexStr(hexStr: "#70BDDB", alpha: 1.0)
    }

    // 少し濃いグレー(文字色)
    class func FetiFontColor() -> UIColor {
        return UIColor.hexStr(hexStr: "#D9CA91", alpha: 1.0)
    }

    class func lightYellow() -> UIColor {
        return UIColor.hexStr(hexStr: "#F1F8A6", alpha: 1.0)
    }

}
