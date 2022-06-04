//
//  SKTool.swift
//  Sung
//
//  Created by w on 2021/10/30.
//

import Foundation
import DeviceKit
import UIKit

public
struct SKTool {
    
    private enum Key: String {
        case device = "screenkit.screen.device.key"
        case position = "screenkit.screen.position.key"
    }
    
    private static func save(string: String?, key: Key) {
        guard let text = string else { return }
        UserDefaults.standard.set(text, forKey: key.rawValue)
    }
    
    private static func fetch(key: Key) -> String? {
        guard let text = UserDefaults.standard.string(forKey: key.rawValue) else { return nil }
        return text
    }
    
    private static func clean(key: Key) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    static func deviceId() -> String? {
        guard let id = fetch(key: Key.device), !id.isEmpty else { return nil }
        return id
    }
 
    static func save(device: SKDevice) {
        let description = device.description
        save(string: description, key: Key.device)
    }
    
    static func save(position: SKConstants.SKWindowLayoutOption) {
        UserDefaults.standard.set(position.rawValue, forKey: Key.position.rawValue)
    }
    
    static func position() -> SKConstants.SKWindowLayoutOption {
        let value = UserDefaults.standard.integer(forKey: Key.position.rawValue)
        return SKConstants.SKWindowLayoutOption(rawValue: value) ?? .center
    }
    
}

extension SKTool {
    
    public
    static func startup() {
        let bounds1 = UIScreen.main.bounds
        
        UIScreen.swizzling
        UIWindow.swizzling
        UINavigationBar.swizzling
        
        let bounds2 = UIScreen.main.bounds
        
        // assert(bounds1 != bounds2, "⚠️: 方法交换出错！")
        print("bounds1:\(bounds1.width) x \(bounds1.height)")
        print("bounds2:\(bounds2.width) x \(bounds2.height)")
        
        
        guard let window = UIWindow.rootWindow() else { return }
        
        
        let deltaW = bounds1.width - bounds2.width
        let deltaH = bounds1.height - bounds2.height
        
        if Int(deltaW) > 0 || Int(deltaH) > 0 {
            // 长或者宽和原来的不相等，则是发生了尺寸变化(设置了不同系列的)
            var x: CGFloat = deltaW / 2
            var y: CGFloat = deltaH / 2
            let description = SKConstants.configuration?.option.description ?? "中"
            if description.hasPrefix("左") {
                x = 0
            } else if description.hasPrefix("右") {
                x = deltaW
            }
            if description.contains("上") {
                y = 0
            } else if description.contains("下") {
                y = deltaH
            }
            
            let frame = CGRect(x: x, y: y, width: bounds2.width, height: bounds2.height)
            window.frame = frame
        }
        
    }
    
    public
    static func show() {
        let nav = UINavigationController(rootViewController: SKViewController())
        nav.navigation.configuration.isEnabled = true
        nav.modalPresentationStyle = .fullScreen
        UIWindow.rootWindow()?.rootViewController?.present(nav, animated: true, completion: nil)
    }
    
}
