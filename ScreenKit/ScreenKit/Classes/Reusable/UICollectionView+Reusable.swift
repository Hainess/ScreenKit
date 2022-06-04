//
//  UICollectionView+Reusable.swift
//  
//
//  Created by Hainess on 2019/11/1.
//  Copyright © 2019 Sung. All rights reserved.
//

import UIKit
import Foundation

extension UICollectionView {

    final func register<T: UICollectionViewCell>(cellType: T.Type) {
        register(cellType.self, forCellWithReuseIdentifier: cellType.reuseId)
    }

    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        let bareCell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath)
        guard let cell = bareCell as? T else {
            fatalError("未注册Cell!")
        }
        return cell
    }

    final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String) {
        register(supplementaryViewType.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: supplementaryViewType.reuseId)
    }

    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, for indexPath: IndexPath, viewType: T.Type = T.self) -> T {
        let view = self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: viewType.reuseId, for: indexPath)
        guard let typedView = view as? T else {
            fatalError("未注册 Header / Footer")
        }
        return typedView
    }

}
