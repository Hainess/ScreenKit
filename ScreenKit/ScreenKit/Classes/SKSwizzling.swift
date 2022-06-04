//
//  SKSwizzling.swift
//  Sung
//
//  Created by w on 2021/10/30.
//

import Foundation
import UIKit

extension NSObject {
    
    static func swizzleInstance(_ selector1: Selector, _ selector2: Selector) {
        guard
            let method1 = class_getInstanceMethod(self, selector1),
            let method2 = class_getInstanceMethod(self, selector2)
        else {
            return
        }
        method_exchangeImplementations(method1, method2)
    }
    
    static func swizzleClass(_ selector1: Selector, selector2: Selector) {
        guard
            let method1 = class_getClassMethod(self, selector1),
            let method2 = class_getClassMethod(self, selector2)
        else {
            return
        }
        if (class_addMethod(self, selector1, method_getImplementation(method2), method_getTypeEncoding(method2))) {
            class_replaceMethod(self, selector2, method_getImplementation(method1), method_getTypeEncoding(method1))
        } else {
            method_exchangeImplementations(method1, method2)
        }
    }
    
}

extension UIScreen {
    
    static let swizzling: Void = {
        let s1 = #selector(getter: bounds)
        let s2 = #selector(getter: swizzle_bounds)
        swizzleInstance(s1, s2)
    }()
    
    @objc
    private var swizzle_bounds: CGRect {
        guard let device = SKConstants.configuration?.device else { return self.swizzle_bounds }
        return CGRect(x: 0, y: 0, width: device.diamensions.width, height: device.diamensions.height)
    }
    
}

extension UIWindow {
    
    static let swizzling: Void = {
        let s1 = #selector(getter: safeAreaInsets)
        let s2 = #selector(getter: swizzle_safeAreaInsets)
        swizzleInstance(s1, s2)
    }()
    
    @objc
    private var swizzle_safeAreaInsets: UIEdgeInsets {
        guard let device = SKConstants.configuration?.device  else { return self.swizzle_safeAreaInsets }
        return device.safeArea
    }
    
}

extension UINavigationBar {
    
    static let swizzling: Void = {
        let s1 = #selector(setter: frame)
        let s2 = #selector(setter: swizzle_frame)
        swizzleInstance(s1, s2)
    }()
    
    @objc
    private var swizzle_frame: CGRect {
        get {
            return self.frame
        }
        set {
            self.swizzle_frame = newValue
        }
    }
    
}
