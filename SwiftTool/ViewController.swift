//
//  ViewController.swift
//  SwiftTool
//
//  Created by 银河 on 2019/6/24.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit


class Example: NSObject {
    var cls: AnyObject.Type
    
    init(cls: AnyObject.Type) {
        self.cls = cls
    }
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        
        dataSource.append(Example(cls: RotationExampleViewController.self))

        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let example = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "example")!
        cell.textLabel?.text = NSStringFromClass(example.cls)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let example = dataSource[indexPath.row]
        let cls = example.cls.alloc()
        if let vc = cls as? UIViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
