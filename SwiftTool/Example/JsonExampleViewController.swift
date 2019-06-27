//
//  JsonExampleViewController.swift
//  SwiftTool
//
//  Created by apple on 2019/6/27.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit

class JsonExampleViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "SwiftJSON解析Demo"
        
        let label = UILabel()
        label.text = "请看控制台打印信息"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(100)
        }
        
        
        let data = YHGetLocalJSONFile(file: "exampleJSON")
        if data == nil {
            return
        }
        let json = JSON(data!)
        
        // json.debugDescription      打印调试信息
        // json.rawString()           原始JSON字符串
        // json.rawValue              初始化传入的原始值
        // json["result"].exists()    某个key所对应的value是否存在
        // result["list"].type        某个key所对应的value的类型
        
        print(json.debugDescription)
        
        print(json["result"].exists())
        
        if json["result"].exists() {
            let model = ResultModel(result: json["result"])
            print(model)
        }
    }
}






struct ResultModel {
    
    let expPhone: String
    let type: String
    let deliverystatus: String
    let issign: String
    let courier: String
    let expName: String
    let list:[ListModel]
    
    init(result: JSON) {
        self.expPhone = result["expPhone"].string ?? ""
        self.type = result["type"].string ?? ""
        self.deliverystatus = result["deliverystatus"].string ?? ""
        self.issign = result["issign"].string ?? ""
        self.courier = result["courier"].string ?? ""
        self.expName = result["expName"].string ?? ""
        
        
        var list: [ListModel] = [ListModel]()
        if result["list"].type == .array {
            result["list"].arrayValue.forEach { (json) in
                let model = ListModel(list: json)
                list.append(model)
            }
        }
        self.list = list
    }
}


struct ListModel {
    let status: String
    let time: String
    init(list: JSON) {
        self.status = list["status"].string ?? ""
        self.time = list["time"].string ?? ""
    }
}
