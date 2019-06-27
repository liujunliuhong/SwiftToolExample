//
//  RxSwiftExampleViewController.swift
//  SwiftTool
//
//  Created by apple on 2019/6/27.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit
import RxSwift

class RxSwiftExampleViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "RxSwiftDemo"
        
    }

}
