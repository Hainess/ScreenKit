//
//  UIColor+Extension.swift
//  Sung
//
//  Created by w on 2021/9/25.
//

import Foundation
import UIKit

extension UIColor {

    /// 生成颜色（16进制）
    /// - Parameters:
    ///   - hex: 16进制数值 0x000000
    ///   - alpha: 透明度
    convenience init(_ hex: Int, _ alpha: CGFloat = 1.0) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }

    /// 生成颜色（16进制字符串）
    /// - Parameters:
    ///   - hex: 16进制数值 0x000000
    ///   - alpha: 透明度
    convenience init(hexString: String, _ alpha: CGFloat = 1.0) {
        var rgbValue: UInt64 = 0
        let scanner = Scanner(string: hexString)
        scanner.scanLocation = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: alpha
        )
    }

    /// 生成随机颜色
    /// - Returns: 返回生成的随机颜色
    class func random() -> UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256)), green: CGFloat(arc4random_uniform(256)), blue: CGFloat(arc4random_uniform(256)), alpha: 1)
    }
    
}

extension String {

    var color: UIColor? {
        let hexText = self.replacingOccurrences(of: "#", with: "")
        return UIColor(hexString: hexText)
    }

}

extension CGColor {

    func toHexString() -> String {
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        let hex = String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hex
    }

}
