//
//  RxSwiftInputValidateViewController.swift
//  SwiftTool
//
//  Created by apple on 2019/6/28.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RxSwiftInputValidateViewController: UIViewController {

    let disposeBag = DisposeBag()
    private var viewModel: RxSwiftInputValidateViewModel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var usernameTipLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTipLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "输入验证（类似登录信息验证）"
        
        self.usernameTipLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
        self.passwordTipLabel.text = "Password has to be at least \(minimalPasswordLength) characters"
        
        self.viewModel = RxSwiftInputValidateViewModel(
            username: usernameTextField.rx.text.orEmpty.asObservable(),
            password: passwordTextField.rx.text.orEmpty.asObservable()
        )
        
        self.viewModel.usernameValid
            .bind(to: self.usernameTipLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        self.viewModel.passwordValid
            .bind(to: self.passwordTipLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        self.viewModel.everythingValid
            .bind(to: self.doneButton.rx.isDoneButtonEnable)
            .disposed(by: disposeBag)
        
        self.doneButton.rx.tap
            .subscribe(onNext: {
                print("Done")
            })
            .disposed(by: disposeBag)
    }
}


extension Reactive where Base: UIButton {
    var isDoneButtonEnable: Binder<Bool> {
        return Binder(self.base, binding: { (button, isEnable) in
            if !isEnable {
                button.backgroundColor = .gray
                button.isUserInteractionEnabled = false
            } else {
                button.backgroundColor = .red
                button.isUserInteractionEnabled = true
            }
        })
    }
}
