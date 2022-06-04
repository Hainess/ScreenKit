//
//  Reusable.swift
//  
//
//  Created by Hainess on 2019/11/1.
//  Copyright © 2019 Sung. All rights reserved.
//  

import Foundation
import UIKit

protocol Reusable {
    static var reuseId: String { get }
}

extension Reusable {
    static var reuseId: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: Reusable {}
extension UITableViewCell: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}
