//
//  RotationExampleViewController.swift
//  SwiftTool
//
//  Created by apple on 2019/6/25.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit
import SnapKit




class RotationExampleViewController: YHBaseViewController {

    private lazy var button1: UIButton = {
       let button = UIButton(type: .system)
        button.backgroundColor = .gray
        button.setTitle("Presesent一个竖屏的控制器", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(clickPresent), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.cusNaviBar.isHideNaviBar = false
        
        self.YH_ForcedToRotation(.landscapeRight)
        
        
        safeAreaView.addSubview(button1)
        
        button1.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX);
            make.top.equalTo(self.safeAreaView).offset(50)
            make.width.greaterThanOrEqualTo(120)
            make.height.equalTo(50)
        }
    }
    
    @objc
    func clickPresent() {
        let vc = RotationPresentViewController()
        let navi = UINavigationController(rootViewController: vc)
        navi.isNavigationBarHidden = true
        self.present(navi, animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    // 限制只能横屏
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.popViewController(animated: true)
    }
}


class RotationPresentViewController: YHBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        self.cusNaviBar.isHideNaviBar = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // 限制只能竖屏
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
}
