//
//  RxSwiftInputValidateViewModel.swift
//  SwiftTool
//
//  Created by apple on 2019/6/28.
//  Copyright © 2019 yinhe. All rights reserved.
//

import Foundation
import RxSwift

let minimalUsernameLength: Int = 4
let minimalPasswordLength: Int = 3

struct RxSwiftInputValidateViewModel {
    
    
    
    let usernameValid: Observable<Bool>
    let passwordValid: Observable<Bool>
    
    let everythingValid: Observable<Bool>
    
    init(username: Observable<String>, password: Observable<String>) {
        
        self.usernameValid = username.map { $0.count >= minimalUsernameLength }.share(replay: 1)
        self.passwordValid = password.map { $0.count >= minimalPasswordLength }.share(replay: 1)
        
        self.everythingValid = Observable.combineLatest(self.usernameValid, self.passwordValid) { $0 && $1 }.share(replay: 1)
        
    }
}
