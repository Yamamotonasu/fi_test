//
//  CreateUserModel.swift
//  FirebaseTest
//
//  Created by 山本裕太 on 2020/01/12.
//  Copyright © 2020 山本裕太. All rights reserved.
//

import Foundation
import Firebase

struct CreateUserModel {
    
    static func createUser(info with: InputInfomation) {
        
    }
    
    struct InputInfomation {

        var userName: String
        var email: String
        var password: String

        // MARK: - init

        init(userName: String, email: String, password: String) {
            self.userName = userName
            self.email = email
            self.password = password
        }

    }
}
