//
//  SKTopBar.swift
//  Sung
//
//  Created by w on 2021/10/30.
//

import Foundation
import UIKit
import SnapKit

final class SKTopBar: UIView {
    
    /// 顶栏高度
    var barHeight: CGFloat {
        return (SKConstants.configuration?.device.statusBarHeight ?? 0) + 44
    }
    
    let leftButton = UIButton().then {
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    let rightButton = UIButton().then {
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    let titleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.textAlignment = .center
        $0.textColor = .black
        $0.text = "屏幕尺寸"
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        makeData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("use init() instead")
    }
    
    private func makeUI() {
        backgroundColor = .white
        clipsToBounds = true
        
        addSubview(leftButton)
        addSubview(titleLabel)
        addSubview(rightButton)
        
        leftButton.snp.makeConstraints { make in
            make.width.equalTo(44)
            make.height.equalTo(18)
            make.leading.equalTo(15)
            make.bottom.equalTo(-13)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-69)
            make.bottom.equalToSuperview().offset(-7)
        }
        
        rightButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        leftButton.expand(15)
        rightButton.expand(10)

        setNeedsLayout()
        layoutIfNeeded()
        
        print("bounds: \(leftButton.frame)")
        
        print("bounds: \(leftButton.bounds)")
        
        print("bounds: \(leftButton.enlargeRect())")
        
    }
    
    private func makeData() {
        leftButton.setTitle("取消", for: .normal)
        rightButton.setTitle("保存", for: .normal)
        // rightButton.setImage(UIImage(named: "detail_btn_share"), for: .normal)
        // leftButton.setImage(UIImage(named: "icon_mk_back"), for: .normal)
    }
    
}
