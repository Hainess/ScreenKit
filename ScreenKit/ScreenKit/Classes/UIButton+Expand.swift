//
//  UIButton+.swift
//  ScreenKit_Example
//
//  Created by likpia on 2022/6/4.
//  Copyright © 2022 CocoaPods. All rights reserved.

import UIKit

extension UIButton {

    struct Associated {
        static var top: UInt8 = 0
        static var right: UInt8 = 0
        static var bottom: UInt8 = 0
        static var left: UInt8 = 0
    }
    
    func expand(_ size: CGFloat) {
        setExpandInsets(UIEdgeInsets(top: size, left: size, bottom: size, right: size))
    }
    
    func setExpandInsets(_ insets: UIEdgeInsets) {
        objc_setAssociatedObject(self, &Associated.top, insets.top, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &Associated.right, insets.right, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &Associated.bottom, insets.bottom, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        objc_setAssociatedObject(self, &Associated.left,  insets.left, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    func getExpandInsets() -> UIEdgeInsets {
        guard
            let top = objc_getAssociatedObject(self, &Associated.top) as? CGFloat,
            let right = objc_getAssociatedObject(self, &Associated.right) as? CGFloat,
            let bottom = objc_getAssociatedObject(self, &Associated.bottom) as? CGFloat,
            let left = objc_getAssociatedObject(self, &Associated.left) as? CGFloat
        else {
            return .zero
        }
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    func enlargeRect() -> CGRect {
        let insets = getExpandInsets()
        
        if insets == .zero {
            return bounds
        }
        
        return CGRect(
            x: bounds.origin.x - insets.left,
            y: bounds.origin.y - insets.top,
            width: bounds.width + insets.left + insets.right,
            height: bounds.height + insets.top + insets.bottom
        )
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect: CGRect = self.enlargeRect()
        if rect == bounds {
            return super.point(inside: point, with: event)
        }
        return rect.contains(point) ? true : false
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !isHidden, alpha > 0, isUserInteractionEnabled, isEnabled else { return nil }
        
        let rect: CGRect = self.enlargeRect()
        if rect == bounds {
            return super.hitTest(point, with: event)
        }
        
        return rect.contains(point) ? self : nil
    }
    
}

