//
//  SKConstants.swift
//  Sung
//
//  Created by w on 2021/10/30.
//

import Foundation
import DeviceKit

struct SKConstants {
    
    static var configuration: (device: SKDevice, option: SKWindowLayoutOption)? = {
        guard let id = SKTool.deviceId(), let device = SKDevice(identifier: id)  else {
            let device = SKDevice(device: Device.current)
            let option = SKTool.position()
            return (device, option)
        }
        let option = SKTool.position()
        return (device, option)
    }()
    
    enum SKWindowLayoutOption: Int, CaseIterable {
        case center
        case top, bottom, left, right
        case topRight, topLeft
        case bottomLeft, bottomRight

        var description: String {
            switch self {
            case .top:
                return "上"
            case .bottom:
                return "下"
            case .left:
                return "左"
            case .right:
                return "右"
            case .center:
                return "中"
            case .topLeft:
                return "左上"
            case .topRight:
                return "右上"
            case .bottomLeft:
                return "左下"
            case .bottomRight:
                return "右下"
            }
        }
        
    }
    
}
