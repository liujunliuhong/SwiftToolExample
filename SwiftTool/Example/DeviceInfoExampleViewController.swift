//
//  DeviceInfoExampleViewController.swift
//  SwiftTool
//
//  Created by apple on 2019/6/26.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit
import SnapKit

class DeviceInfoExampleViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.backgroundColor = .gray
        label.textColor = .white
        view.addSubview(label)
        
        
        label.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.equalTo(300)
            make.height.greaterThanOrEqualTo(300)
        }
        
        
        label.text = "您的iPhone版本号:\(UIDevice.current.systemVersion)\n您的iPhone机器版本号:\(UIDevice.YHMachine())\n您的iPhone名称:\(UIDevice.YHMachineName())"
    }
}
