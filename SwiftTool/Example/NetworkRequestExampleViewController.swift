//
//  NetworkRequestExampleViewController.swift
//  SwiftTool
//
//  Created by 银河 on 2019/6/24.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit
import Moya
import Alamofire

class NetworkRequestExampleViewController: UIViewController {

    private lazy var alamofireButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .gray
        button.setTitle("Alamofire请求", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(alamofireRequest), for: .touchUpInside)
        return button
    }()
    
    private lazy var moyaButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .gray
        button.setTitle("Moya请求", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(moyaRequest), for: .touchUpInside)
        return button
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "网络请求Demo"
        view.backgroundColor = .white
        
        view.addSubview(alamofireButton)
        view.addSubview(moyaButton)
        
        alamofireButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.top.equalTo(self.view).offset(UIApplication.shared.statusBarFrame.size.height + 44.0 + 60)
        }
        moyaButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.top.equalTo(self.alamofireButton.snp.bottom).offset(60)
        }
    }
    
    @objc
    func alamofireRequest() {
        
    }
    
    @objc
    func moyaRequest() {
        
    }

}
