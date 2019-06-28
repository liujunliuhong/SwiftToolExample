//
//  ViewController.swift
//  SwiftTool
//
//  Created by 银河 on 2019/6/24.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum PushType {
    case networkRequest
    case rotation
    case permission
    case deviceInfo
    case json
    case rxswift
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
    
    let disposeBag = DisposeBag()

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
        dataSource.append(Example(title:"网络请求Demo", type: .networkRequest))
        dataSource.append(Example(title:"权限请求Demo", type: .permission))
        dataSource.append(Example(title:"设备信息Demo", type: .deviceInfo))
        dataSource.append(Example(title:"SwiftJSON解析Demo", type: .json))
        dataSource.append(Example(title:"RxSwift Demo", type: .rxswift))

        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        UIDevice.YHPrintBasicInfo()
        
        // RxSwift
//        YHDebugLog("RxSwift")
//        let numbers: Observable<Int> = Observable<Int>.create { (observer) -> Disposable in
//            observer.onNext(1)
//            observer.onNext(2)
//            observer.onNext(3)
//            observer.onCompleted()
//            return Disposables.create()
//        }
//
//        numbers.subscribe(onNext: { (value) in
//            print(value)
//        }, onError: { (error) in
//            print("Error: \(error)")
//        }, onCompleted: {
//            print("onCompleted")
//        }) {
//            print("onDispose")
//        }.disposed(by: disposeBag)
//
//
//        let single = Single<Int>.create { (single) -> Disposable in
//            single(.success(2))
//            //single(.error(<#T##Error#>))
//            return Disposables.create()
//        }
//
//        let complete =  Completable.create { (complete) -> Disposable in
//            complete(.completed)
//            //complete(.error(<#T##Error#>))
//            return Disposables.create()
//        }
//
//        Maybe<Int>.create { (maybe) -> Disposable in
//            maybe(.success(1))
//            maybe(.completed)
//            //maybe(.error(<#T##Error#>))
//            return Disposables.create()
//        }
//        //
//        let textField = UITextField()
//        let m = textField.rx.text.asDriver()
//
//        let button = UIButton(type: .custom)
//        button.rx.tap.asSignal()
//
//        button.rx.isHidden
//
//
//        let observer: Binder<Bool> = Binder(textField) { (textField, isHide) in
        
//        }
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
        case .json:
            self.navigationController?.pushViewController(JsonExampleViewController(), animated: true)
        case .networkRequest:
            self.navigationController?.pushViewController(NetworkRequestExampleViewController(), animated: true)
        case .rxswift:
            self.navigationController?.pushViewController(RxSwiftExampleViewController(), animated: true)
        default:
            break
        }
        
    }
}
