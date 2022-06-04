//
//  SKViewController.swift
//  Sung
//
//  Created by w on 2021/10/30.
//

import Foundation
import SnapKit
import RxDataSources
import RxSwift
import RxCocoa
import UIKit
import EachNavigationBar
import Then


class SKViewController: UIViewController {

    private var vm = SKViewModel()
    
    private let bag = DisposeBag()
    
    private lazy var topBar = SKTopBar()
    
    private lazy var themeTable = makeThemeTable()
    
    private lazy var segment: UISegmentedControl = {
        let titles = vm.options.value.map { $0.description }
        let m = UISegmentedControl(items: titles)
        m.backgroundColor = UIColor(0x2EB885)
        m.selectedSegmentIndex = vm.optionIndex
        m.addTarget(self, action: #selector(segmentAction), for: .valueChanged)
        return m
    }()
    
    override var prefersStatusBarHidden: Bool {
        return false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    deinit {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
 
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    private func makeUI() {
        navigation.bar.isHidden = true
        view.addSubview(topBar)
        view.addSubview(segment)
        view.addSubview(themeTable)
        
        topBar.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(topBar.barHeight)
        }
        
        segment.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(topBar.snp.bottom)
            make.height.equalTo(40)
        }
        
        themeTable.snp.makeConstraints { make in
            make.top.equalTo(segment.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    private func makeData() {
        
        // TopBar Action
        topBar.leftButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: bag)
        
        topBar.rightButton.rx.controlEvent(.touchUpInside).subscribe(onNext: { [weak self] in
            self?.vm.input(event: .save)
            /// UIView.showAutoHud(with: "重启App生效！")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                exit(0)
            }
        }).disposed(by: bag)
        
        // ThemeTable
        vm.items.bind(to: themeTable.rx.items(cellIdentifier: SKViewCell.reuseId, cellType: SKViewCell.self)) { (row, element, cell) in
            cell.selectionStyle = .none
            cell.set(device: element)
        }.disposed(by: bag)

        themeTable.rx.modelSelected(SKDevice.self).subscribe(onNext:  { [weak self] item in
            self?.vm.input(event: .select(item))
        }).disposed(by: bag)
        
    }
    
    private func bind() {
        
    }
    
    @objc
    private func segmentAction(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        vm.input(event: .switchOption(index))
    }
    
}

extension SKViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }
    
}

extension SKViewController {
    
    private func makeThemeTable() -> UITableView {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = UIColor(0xEAF7F2)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.register(cellType: SKViewCell.self)
        tableView.rowHeight = 49
        //tableView.allowsSelection = false
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.tableFooterView = UIView()
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        return tableView
    }
    
}

class SKViewCell: UITableViewCell {
    
    private var nameLabel = UILabel().then {
        $0.textAlignment = .center
    }
    
    private var markLine = UIView().then {
        $0.backgroundColor = UIColor(0x2EB885)
        $0.layer.cornerRadius = 2.5
        $0.layer.masksToBounds = true
        $0.isHidden = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(markLine)
        addSubview(nameLabel)
        markLine.snp.makeConstraints { make in
            make.width.equalTo(5)
            make.height.equalTo(29)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(20)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func set(device: SKDevice) {
        
        nameLabel.text = "\(device.description): \(device.diamensions.width)x\(device.diamensions.height)"
        if device.isSelected {
            nameLabel.textColor = UIColor(0x2EB885)
            nameLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
            markLine.isHidden = false
            backgroundColor = .white
        } else {
            nameLabel.textColor = UIColor(0x999999)
            nameLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            markLine.isHidden = true
            backgroundColor = UIColor(0xEAF7F2)
        }
        
    }
    
}


