//
//  UITableView+Reusable.swift
//  
//
//  Created by Hainess on 2019/11/1.
//  Copyright © 2019 Sung. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

    final func register<T: UITableViewCell>(cellType: T.Type) {
        register(cellType.self, forCellReuseIdentifier: cellType.reuseId)
    }

    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseId, for: indexPath) as? T else {
            fatalError("未注册TableViewCell!")
        }
        return cell
    }

    final func register<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type) {
        register(headerFooterViewType.self, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseId)
    }

    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self) -> T? {
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseId) as? T? else {
            fatalError("未注册Header / Footer!")
        }
        return view
    }

}
