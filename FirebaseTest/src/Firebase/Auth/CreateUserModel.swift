//
//  CreateUserModel.swift
//  FirebaseTest
//
//  Created by 山本裕太 on 2020/01/12.
//  Copyright © 2020 山本裕太. All rights reserved.
//

import Foundation
import Firebase

struct CreateUserModel<E> {

//    static func createUser(info data: InputInfomation) {
//        Auth.auth().createUser(withEmail: data.email, password: data.password) { (result, error) in
//            if let error = error {
//                debugPrint(error.localizedDescription)
//            }
//            guard let user = result?.user else { return }
//            self.dismiss(animated: true)
//        }
//    }

    /**
     * 入力内容をモデル化
     */
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

extension CreateUserModel where E == UIViewController {

    typealias View = E

//    static func createUser(info data: InputInfomation, @escaping completion: (AuthResultCallback) -> Void) {
//        Auth.auth().createUser(withEmail: data.email, password: data.password) { (result, error) in
//            if let error = error {
//                debugPrint(error.localizedDescription)
//            }
//            guard let user = result?.user else { return }
//            completion((result?.user, error))
//        }
//    }

}
