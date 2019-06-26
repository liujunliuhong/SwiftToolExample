//
//  PermissionExampleViewController.swift
//  SwiftTool
//
//  Created by apple on 2019/6/26.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit
import SnapKit

class PermissExampleModel: NSObject {
    let title: String
    let type: YHPermissionType
    init(title: String, type: YHPermissionType) {
        self.title = title
        self.type = type
    }
}

class PermissionExampleViewController: UIViewController {
    

    var list: [PermissExampleModel] = [PermissExampleModel]()
    
    
    let identifier: String = "permissionExampleIdentifier"
    
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
        navigationItem.title = "Permission Example"
        
        self.list.append(PermissExampleModel(title: "相机权限", type: .camera))
        self.list.append(PermissExampleModel(title: "麦克风权限", type: .microphone))
        self.list.append(PermissExampleModel(title: "照片权限", type: .photo))
        self.list.append(PermissExampleModel(title: "通讯录权限", type: .contacts))
        self.list.append(PermissExampleModel(title: "Reminder权限", type: .reminder))
        self.list.append(PermissExampleModel(title: "Calendar权限", type: .calendar))
        
        self.view.addSubview(self.tableView)
        
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
    }
}


extension PermissionExampleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
        let model = self.list[indexPath.row];
        cell.textLabel?.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.list[indexPath.row];
        YHPermission.requestAuthorization(for: model.type) { (result) in
            YHDebugLog(result.debugDescription)
        }
    }
}
