//
//  RoundedButton.swift
//  FirebaseTest
//
//  Created by 山本裕太 on 2020/01/25.
//  Copyright © 2020 山本裕太. All rights reserved.
//

import Foundation
import UIKit

class RoundedButton: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = 5
    }

}
