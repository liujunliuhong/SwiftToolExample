//
//  RxSwiftExampleViewController.swift
//  SwiftTool
//
//  Created by apple on 2019/6/27.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

enum RxSwiftExampleType {
    case numberAdd
    case inputValidate
}

struct RxSwiftExampleModel {
    let title: String
    let type: RxSwiftExampleType
    init(title: String, type: RxSwiftExampleType) {
        self.title = title
        self.type = type
    }
}

class RxSwiftExampleViewController: UIViewController {

    private let identifier: String = "RxSwiftExampleIdentifier"
    private var dataSource: [RxSwiftExampleModel] = [RxSwiftExampleModel]()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: identifier)
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "RxSwiftDemo"
        
        dataSource.append(RxSwiftExampleModel(title: "加法运算", type: .numberAdd))
        dataSource.append(RxSwiftExampleModel(title: "输入验证(类似登录验证)", type: .inputValidate))
        
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }

}

extension RxSwiftExampleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
        let model = dataSource[indexPath.row]
        cell.textLabel?.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = dataSource[indexPath.row]
        switch model.type {
        case .inputValidate:
            self.navigationController?.pushViewController(RxSwiftInputValidateViewController(), animated: true)
        default:
            break
        }
    }
    
}
