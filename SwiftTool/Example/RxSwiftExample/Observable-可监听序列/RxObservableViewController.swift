//
//  RxObservableViewController.swift
//  SwiftTool
//
//  Created by apple on 2019/8/13.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

private let ID = "cell_ID"

class RxObservableViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var dataSource:[String] = [String]()
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: ID)
        return tableView
    }()
    
    
    lazy var rightItemButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("测试", for: .normal)
        return btn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false;
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Observable - 可监听序列"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightItemButton)

        
        dataSource = ["Observable", "Single", "Completable", "Maybe", "Driver", "Signal(注意和Single的区别 signal:信号   singal:一个,单)", "ControlEvent"]
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
}


extension RxObservableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ID)!
        cell.textLabel?.text = title
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            observable() // 不会共享附加作用
        } else if indexPath.row == 1 {
            single() // 不会共享附加作用
        } else if indexPath.row == 2 {
            completable() // 不会共享附加作用
        } else if indexPath.row == 3 {
            maybe() // 不会共享附加作用
        } else if indexPath.row == 4 {
            print("见另外的Demo")
        } else if indexPath.row == 5 {
            // signal
            print("一般情况下状态序列我们会选用 Driver 这个类型，事件序列我们会选用 Signal 这个类型。")
        }
    }
}


extension RxObservableViewController {
    func observable() {
        let observable: Observable<String> = Observable<String>.create { (observable) -> Disposable in
            
            observable.onNext("hello")
            //observable.onError(MyError())
            observable.onCompleted()
            
            return Disposables.create {
                
            }
        }
        observable.subscribe(onNext: { (value) in
            print("value: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }, onCompleted: {
            print("完成")
        }) {
            print("dispose")
        }.disposed(by: disposeBag)
    }
}

extension RxObservableViewController {
    // Single 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，它要么只能发出一个元素，要么产生一个 error 事件。
    // 发出一个元素，或一个 error 事件
    // 不会共享附加作用
    // 一个比较常见的例子就是执行 HTTP 请求，然后返回一个应答或错误。不过你也可以用 Single 来描述任何只有一个元素的序列。
    func single() {
        let singal: Single<String> = Single<String>.create { (single) -> Disposable in
            single(.success("hello"))
            //single(.error(MyError()))
            return Disposables.create {
                
            }
        }
        singal.subscribe(onSuccess: { (value) in
            print("value: \(value)")
        }) { (error) in
            print("error: \(error)")
        }.disposed(by: disposeBag)
    }
}

extension RxObservableViewController {
    // Completable 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，它要么只能产生一个 completed 事件，要么产生一个 error 事件。
    // 发出零个元素
    // 发出一个 completed 事件或者一个 error 事件
    // 不会共享附加作用
    // Completable 适用于那种你只关心任务是否完成，而不需要在意任务返回值的情况。它和 Observable<Void> 有点相似。
    func completable() {
        let completable = Completable.create { (completable) -> Disposable in
            
            completable(.completed)
            //completable(.error(MyError()))
            
            return Disposables.create {
                
            }
        }
        
        completable.subscribe(onCompleted: {
            print("完成")
        }) { (error) in
            print("error: \(error)")
        }.disposed(by: disposeBag)
    }
}

extension RxObservableViewController {
    // Maybe 是 Observable 的另外一个版本。它介于 Single 和 Completable 之间，它要么只能发出一个元素，要么产生一个 completed 事件，要么产生一个 error 事件。
    // 发出一个元素或者一个 completed 事件或者一个 error 事件
    // 不会共享附加作用
    // 如果你遇到那种可能需要发出一个元素，又可能不需要发出时，就可以使用 Maybe。(源码里面调用了completed)
    func maybe() {
        let maybe = Maybe<String>.create { (maybe) -> Disposable in
            //maybe(.success("hello"))
            maybe(.completed)
            //maybe(.error(MyError()))
            
            return Disposables.create {
                
            }
        }
        maybe.subscribe(onSuccess: { (value) in
            print("value: \(value)")
        }, onError: { (error) in
            print("error: \(error)")
        }) {
            print("完成")
        }.disposed(by: disposeBag)
    }
}
