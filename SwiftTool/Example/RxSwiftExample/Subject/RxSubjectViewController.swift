//
//  RxSubjectViewController.swift
//  SwiftTool
//
//  Created by apple on 2019/8/12.
//  Copyright © 2019 yinhe. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

private let ID = "rx_subject_example_ID"


class RxSubjectViewController: UIViewController {

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Subject"
        
        dataSource = ["PublishSubject", "ReplaySubject", "BehaviorSubject", "AsyncSubject"]
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    

    

}


extension RxSubjectViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ID)!
        cell.textLabel?.text = title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            // PublishSubject
            publishSubject()
        } else if indexPath.row == 1 {
            
        } else if indexPath.row == 2 {
            
        } else if indexPath.row == 3 {
            
        }
    }
}




extension RxSubjectViewController {
    // PublishSubject 将对观察者发送订阅后产生的元素，而在订阅前发出的元素将不会发送给观察者。如果你希望观察者接收到所有的元素，你可以通过使用 Observable 的 create 方法来创建 Observable，或者使用 ReplaySubject。
    // 如果源 Observable 因为产生了一个 error 事件而中止， PublishSubject 就不会发出任何元素，而是将这个 error 事件发送出来。(error之后的事件就不会发生了)
    func publishSubject() {
        let subject = PublishSubject<String>()
        subject.subscribe{ print("PublishSubject - 1: \($0)") }.disposed(by: disposeBag)
        subject.onNext("a")
        subject.onNext("b")
        subject.subscribe{ print("PublishSubject - 2: \($0)") }.disposed(by: disposeBag)
        subject.onNext("c")
        subject.onNext("d")
        //subject.onError(MyError())
        //subject.onCompleted()
        subject.onNext("e")
        //subject.onCompleted()
    }
}

extension RxSubjectViewController {
    func replaySubject() {
        
    }
}


struct MyError: LocalizedError {
    var errorDescription: String? {
        return "My Error"
    }
}
