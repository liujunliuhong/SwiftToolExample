//
//  ViewController.swift
//  SwiftTool
//
//  Created by 银河 on 2019/6/24.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit

enum PushType {
    case networkRequest
    case rotation
    case permission
    case deviceInfo
}

class Example: NSObject {
    let type: PushType
    let title: String
    
    init(title: String, type: PushType) {
        self.title = title
        self.type = type
    }
}

class ViewController: UIViewController {
    
    var dataSource:[Example] = [Example]()
    

    lazy var tableView: UITableView = {
       let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "example")
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Example"
        
        dataSource.append(Example(title:"屏幕旋转Demo", type: .rotation))
        dataSource.append(Example(title:"权限请求Demo", type: .permission))
        dataSource.append(Example(title:"设备信息Demo", type: .deviceInfo))

        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        UIDevice.YHPrintBasicInfo()
    }

    



    // 使屏幕竖屏，即使从另外一个横屏页面返回也是竖屏
    override var shouldAutorotate: Bool {
        return true
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let example = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "example")!
        cell.textLabel?.text = example.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let example = dataSource[indexPath.row]
        switch example.type {
        case .rotation:
            self.navigationController?.pushViewController(RotationExampleViewController(), animated: true)
        case .permission:
            self.navigationController?.pushViewController(PermissionExampleViewController(), animated: true)
        case .deviceInfo:
            self.navigationController?.pushViewController(DeviceInfoExampleViewController(), animated: true)
        default:
            break
        }
        
    }
}
