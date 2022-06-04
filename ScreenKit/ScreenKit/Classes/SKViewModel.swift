//
//  SKVM.swift
//  Sung
//
//  Created by w on 2021/10/30.
//

import Foundation
import RxSwift
import RxCocoa
import DeviceKit

class SKViewModel {
    
    let items = BehaviorRelay<[SKDevice]>(value: [])
    
    let options = BehaviorRelay<[SKConstants.SKWindowLayoutOption]>(value: SKConstants.SKWindowLayoutOption.allCases)
    
    private(set) var optionIndex: Int = SKTool.position().rawValue
    
    init() {
        
        let enums: [Device] = [
            .iPhone5s,
            .iPhone6s,
            .iPhone6sPlus,
            .iPhone11,
            .iPhone11Pro,
            .iPhone11ProMax,
            .iPhone13Mini,
            .iPhone13,
            .iPhone13ProMax
        ]
        
        let devices = enums.map { SKDevice(device: $0) }
        
        let selected_id = SKTool.deviceId()
        devices.first(where: { $0.identifier == selected_id })?.isSelected = true
        
        items.accept(devices)

    }
  
}

extension SKViewModel {
    
    enum InputEvent {
        case select(SKDevice)
        case save
        case switchOption(Int)
    }
    
    func input(event: InputEvent) {
        switch event {
        case .select(let device):
            let items = items.value
            items.forEach {
                $0.isSelected = (device.identifier == $0.identifier)
            }
            self.items.accept(items)
        case .switchOption(let index):
            optionIndex = index
        case .save:
            guard let item = items.value.first(where: { $0.isSelected == true }),
                  let option = SKConstants.SKWindowLayoutOption(rawValue: optionIndex) else { return }
            SKTool.save(device: item)
            SKTool.save(position: option)
        }
        
    }
    
}
