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
            publishSubject()
        } else if indexPath.row == 1 {
            replaySubject()
        } else if indexPath.row == 2 {
            behaviorSubject()
        } else if indexPath.row == 3 {
            asyncSubject()
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
        subject.onError(MyError())
        //subject.onCompleted()
        subject.onNext("e")
        //subject.onCompleted()
    }
}

extension RxSubjectViewController {
    // 和PublishSubject相比，ReplaySubject会额外接收到订阅前最近发射的 N 条数据
    // 如果把 ReplaySubject 当作观察者来使用，注意不要在多个线程调用 onNext, onError 或 onCompleted。这样会导致无序调用，将造成意想不到的结果
    func replaySubject() {
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        subject.subscribe{ print("ReplaySubject - 1: \($0)") }.disposed(by: disposeBag)
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
        subject.subscribe{ print("ReplaySubject - 2: \($0)") }.disposed(by: disposeBag)
        subject.onNext("d")
        subject.onError(MyError())
        subject.onCompleted()
        subject.subscribe{ print("ReplaySubject - 3: \($0)") }.disposed(by: disposeBag)
    }
}


extension RxSubjectViewController {
    // 当观察者对 BehaviorSubject 进行订阅时，它会将源 Observable 中最新的元素发送出来（如果不存在最新的元素，就发出默认元素）。然后将随后产生的元素发送出来。
    // 如果源 Observable 因为产生了一个 error 事件而中止， BehaviorSubject 就不会发出任何元素，而是将这个 error 事件发送出来。
    // 观察者会额外接收到订阅前最近发射的最近一条数据，如果订阅时还没有数据发射，那么会收到一个初始数据
    func behaviorSubject() {
        let subject = BehaviorSubject<String>(value: "初始数据")
        subject.subscribe{ print("BehaviorSubject - 1: \($0)") }.disposed(by: disposeBag)
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
        subject.subscribe{ print("BehaviorSubject - 2: \($0)") }.disposed(by: disposeBag)
        subject.onNext("d")
        subject.onError(MyError())
        subject.onCompleted()
        subject.subscribe{ print("BehaviorSubject - 3: \($0)") }.disposed(by: disposeBag)
    }
}

extension RxSubjectViewController {
    // AsyncSubject 将在源 Observable 产生完成事件后，发出最后一个元素（仅仅只有最后一个元素），如果源 Observable 没有发出任何元素，只有一个完成事件。那 AsyncSubject 也只有一个完成事件。(只有在产生完成事件或者error事件之后，才会发出元素)
    // 它会对随后的观察者发出最终元素。如果源 Observable 因为产生了一个 error 事件而中止， AsyncSubject 就不会发出任何元素，而是将这个 error 事件发送出来。
    func asyncSubject() {
        let subject = AsyncSubject<String>()
        subject.subscribe{ print("AsyncSubject - 1: \($0)") }.disposed(by: disposeBag)
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
        subject.subscribe{ print("AsyncSubject - 2: \($0)") }.disposed(by: disposeBag)
        subject.onNext("d")
        //subject.onError(MyError())
        subject.onCompleted()
        subject.subscribe{ print("AsyncSubject - 3: \($0)") }.disposed(by: disposeBag)
        subject.onCompleted()
    }
}

struct MyError: LocalizedError {
    var errorDescription: String? {
        return "My Error"
    }
}
