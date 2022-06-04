//
//  UIWindow+Extension.swift
//  ScreenKit
//
//  Created by likpia on 2022/6/4.
//

import Foundation

extension UIWindow {
    
    static func rootWindow() -> UIWindow? {
        if let window = UIApplication.shared.delegate?.window {
            return window
        } else if #available(iOS 13.0, *) {
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            // let delegate = windowScene?.delegate as? SceneDelegate
            // return delegate?.window
            if let window: UIWindow = windowScene?.value(forKeyPath: "delegate.window") as? UIWindow {
                return window
            } else {
                return UIApplication.shared.windows.first
            }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
}
