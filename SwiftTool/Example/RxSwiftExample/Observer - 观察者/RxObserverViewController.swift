//
//  RxObserverViewController.swift
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

class RxObserverViewController: UIViewController {
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
        btn.setTitle("Binder", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return btn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Observer - 观察者"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightItemButton)
        
        dataSource = ["AnyObserver"]
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        rightItemButton.rx.tap.subscribe { [weak self] (_) in
            self?.rightItemClick()
        }.disposed(by: disposeBag)
    }
}
extension RxObserverViewController: UITableViewDataSource, UITableViewDelegate {
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
            anyObserver()
        }
    }
}


extension RxObserverViewController {
    // AnyObserver 可以用来描叙任意一种观察者
    func anyObserver() {
        let observer: AnyObserver<Data> = AnyObserver<Data> { (event) in
            switch event {
            case let .next(value):
                print("value: \(String(data: value, encoding: .utf8) ?? "")")
            case let .error(error):
                print("error: \(error)")
            case .completed:
                print("completed")
            }
        }
        URLSession.shared.rx.data(request: URLRequest(url: URL(string: "https://www.baidu.com")!)).subscribe(observer).disposed(by: disposeBag)
    }
}


extension RxObserverViewController {
    func rightItemClick() {
        let observer: Binder<Bool> = Binder<Bool>(self.rightItemButton) { (btn, isHidden) in
            btn.isHidden = isHidden
        }
//        observer.on(.next(true))
    }
}
