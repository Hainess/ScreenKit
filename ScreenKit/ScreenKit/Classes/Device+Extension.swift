//
//  Device+Extension.swift
//  Sung
//
//  Created by w on 2021/10/30.
//

import Foundation
import DeviceKit

extension Device: RawRepresentable {
    
    public typealias RawValue = String
    
    public init?(rawValue: String) {
        
        switch rawValue {
        case "iPod touch (5th generation)": self = .iPodTouch5
        case "iPod touch (6th generation)": self = .iPodTouch6
        case "iPod touch (7th generation)": self = .iPodTouch7
        case "iPhone 4": self = .iPhone4
        case "iPhone 4s": self = .iPhone4s
        case "iPhone 5": self = .iPhone5
        case "iPhone 5c": self = .iPhone5c
        case "iPhone 5s": self = .iPhone5s
        case "iPhone 6": self = .iPhone6
        case "iPhone 6 Plus": self = .iPhone6Plus
        case "iPhone 6s": self = .iPhone6s
        case "iPhone 6s Plus": self = .iPhone6sPlus
        case "iPhone 7": self = .iPhone7
        case "iPhone 7 Plus": self = .iPhone7Plus
        case "iPhone SE": self = .iPhoneSE
        case "iPhone 8": self = .iPhone8
        case "iPhone 8 Plus": self = .iPhone8Plus
        case "iPhone X": self = .iPhoneX
        case "iPhone Xs": self = .iPhoneXS
        case "iPhone Xs Max": self = .iPhoneXSMax
        case "iPhone Xr": self = .iPhoneXR
        case "iPhone 11": self = .iPhone11
        case "iPhone 11 Pro": self = .iPhone11Pro
        case "iPhone 11 Pro Max": self = .iPhone11ProMax
        case "iPhone SE (2nd generation)": self = .iPhoneSE2
        case "iPhone 12": self = .iPhone12
        case "iPhone 12 Mini": self = .iPhone12Mini
        case "iPhone 12 Pro": self = .iPhone12Pro
        case "iPhone 12 Pro Max": self = .iPhone12ProMax
        case "iPhone 13": self = .iPhone13
        case "iPhone 13 Mini": self = .iPhone13Mini
        case "iPhone 13 Pro": self = .iPhone13Pro
        case "iPhone 13 Pro Max": self = .iPhone13ProMax
        case "iPad 2": self = .iPad2
        case "iPad (3rd generation)": self = .iPad3
        case "iPad (4rd generation)": self = .iPad4
        case "iPad Air": self = .iPadAir
        case "iPad Air 2": self = .iPadAir2
        case "iPad (5th generation)": self = .iPad5
        case "iPad (6th generation)": self = .iPad6
        case "iPad Air (3rd generation)": self = .iPadAir3
        case "iPad (7th generation)": self = .iPad7
        case "iPad (8th generation)": self = .iPad8
        case "iPad (9th generation)": self = .iPad9
        case "iPad Air (4th generation)": self = .iPadAir4
        case "iPad Mini": self = .iPadMini
        case "iPad Mini 2": self = .iPadMini2
        case "iPad Mini 3": self = .iPadMini3
        case "iPad Mini 4": self = .iPadMini4
        case "iPad Mini (5th generation)": self = .iPadMini5
        case "iPad Mini (6th generation)": self = .iPadMini6
        case "iPad Pro (9.7-inch)": self = .iPadPro9Inch
        case "iPad Pro (12.9-inch)": self = .iPadPro12Inch
        case "iPad Pro (12.9-inch) (2nd generation)": self = .iPadPro12Inch2
        case "iPad Pro (10.5-inch)": self = .iPadPro10Inch
        case "iPad Pro (11-inch)": self = .iPadPro11Inch
        case "iPad Pro (12.9-inch) (3rd generation)": self = .iPadPro12Inch3
        case "iPad Pro (11-inch) (2nd generation)": self = .iPadPro11Inch2
        case "iPad Pro (12.9-inch) (4th generation)": self = .iPadPro12Inch4
        case "iPad Pro (11-inch) (3rd generation)": self = .iPadPro11Inch3
        case "iPad Pro (12.9-inch) (5th generation)": self = .iPadPro12Inch5
        case "HomePod": self = .homePod
        default: self = .unknown(rawValue)
        }
        
    }
    
    public var rawValue: String {
        self.description
    }
    
}

class SKDevice: CustomStringConvertible {
    private(set) var device: Device
    private(set) var diagonal: CGFloat = 0
    private(set) var screenRatio: (Double, Double)
    private(set) var statusBarHeight: CGFloat = 20
    
    private(set) var diamensions: CGSize
    private(set) var resolution: CGSize
    private(set) var scaleFactor: CGFloat
    private(set) var description: String
    var identifier: String { return description }
    
    private(set) var safeArea: UIEdgeInsets = .zero
    
    var isSelected: Bool = false
    
    convenience init?(identifier: String) {
        guard let device = Device(rawValue: identifier) else { return nil }
        self.init(device: device)
    }
    
    init(device: Device) {
        self.device = device
        diagonal = device.diagonal
        screenRatio = device.screenRatio
        description = device.description
    
        statusBarHeight = device.hasSensorHousing ? 40 : 20
        
        switch device {
        case .iPhone4, .iPhone4s:
            diamensions = CGSize(width: 320, height: 480)
            resolution  = CGSize(width: 640, height: 960)
            scaleFactor = 2.0
        case .iPhone5, .iPhone5c, .iPhone5s, .iPhoneSE:
            diamensions = CGSize(width: 320, height: 568)
            resolution  = CGSize(width: 640, height: 1136)
            scaleFactor = 2.0
        case .iPhoneSE2, .iPhone6, .iPhone6s, .iPhone7, .iPhone8:
            diamensions = CGSize(width: 375, height: 667)
            resolution  = CGSize(width: 750, height: 1334)
            scaleFactor = 2.0
        case .iPhone6Plus, .iPhone6sPlus, .iPhone7Plus, .iPhone8Plus:
            diamensions = CGSize(width: 414, height: 736)
            resolution  = CGSize(width: 1242, height: 2208)
            scaleFactor = 3.0
        case .iPhoneXR, .iPhone11:
            diamensions = CGSize(width: 414, height: 896)
            resolution  = CGSize(width: 828, height: 1792)
            scaleFactor = 2.0
            safeArea = UIEdgeInsets(top: 44, left: 0, bottom: 34, right: 0)
        case .iPhoneX, .iPhoneXS:
            diamensions = CGSize(width: 375, height: 812)
            resolution  = CGSize(width: 1125, height: 2436)
            scaleFactor = 3.0
            safeArea = UIEdgeInsets(top: 44, left: 0, bottom: 34, right: 0)
        case .iPhoneXSMax ,.iPhone11ProMax:
            diamensions = CGSize(width: 414, height: 896)
            resolution  = CGSize(width: 1242, height: 2688)
            scaleFactor = 3.0
            safeArea = UIEdgeInsets(top: 44, left: 0, bottom: 34, right: 0)
        case .iPhone12Mini, .iPhone13Mini:
            diamensions = CGSize(width: 360, height: 780)
            resolution  = CGSize(width: 1080, height: 2340)
            scaleFactor = 3.0
            safeArea = UIEdgeInsets(top: 44, left: 0, bottom: 34, right: 0)
        case .iPhone12, .iPhone12Pro, .iPhone13, .iPhone13Pro:
            diamensions = CGSize(width: 390, height: 844)
            resolution  = CGSize(width: 1170, height: 2532)
            scaleFactor = 3.0
            safeArea = UIEdgeInsets(top: 47, left: 0, bottom: 34, right: 0)
        case .iPhone12ProMax, .iPhone13ProMax:
            diamensions = CGSize(width: 428, height: 926)
            resolution  = CGSize(width: 1284, height: 2278)
            scaleFactor = 3.0
            safeArea = UIEdgeInsets(top: 47, left: 0, bottom: 34, right: 0)
        default:
            diamensions = CGSize(width: 428, height: 926)
            resolution  = CGSize(width: 1284, height: 2278)
            scaleFactor = 3.0
            safeArea = UIEdgeInsets(top: 47, left: 0, bottom: 34, right: 0)
        }
    }
}
