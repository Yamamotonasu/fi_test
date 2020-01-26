//
//  UIView+Extended.swift
//  FirebaseTest
//
//  Created by 山本裕太 on 2020/01/26.
//  Copyright © 2020 山本裕太. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    public func checkTranslatesAutoresizing(withView: UIView?, toView: UIView?) {
        if withView?.translatesAutoresizingMaskIntoConstraints == true {
            withView?.translatesAutoresizingMaskIntoConstraints = false
        }
        if toView?.translatesAutoresizingMaskIntoConstraints == true {
            toView?.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    public func addPin(withView:UIView, attribute:NSLayoutConstraint.Attribute, toView:UIView?, constant:CGFloat) -> NSLayoutConstraint {
        checkTranslatesAutoresizing(withView: withView, toView: toView)
        return addPinConstraint(addView: self, withItem: withView, toItem: toView, attribute: attribute, constant: constant)
    }

    public func addPin(withView:UIView, isWithViewTop:Bool, toView:UIView?, isToViewTop:Bool, constant:CGFloat) -> NSLayoutConstraint {
        checkTranslatesAutoresizing(withView: withView, toView: toView)
        return addConstraint(
            addView: self,
            relation: .equal,
            withItem: withView,
            withAttribute: (isWithViewTop == true ? .top : .bottom),
            toItem: toView,
            toAttribute: (isToViewTop == true ? .top : .bottom),
            constant: constant
        )
    }

    public func allPin(subView: UIView) {
        self.allPin(subView: subView, insets: UIEdgeInsets.zero)
    }

    public func allPin(subView: UIView, insets: UIEdgeInsets) {
        checkTranslatesAutoresizing(withView: subView, toView: nil)
        _ = addPinConstraint(addView: self, withItem: subView, toItem: self, attribute: .top, constant: insets.top)
        _ = addPinConstraint(addView: self, withItem: subView, toItem: self, attribute: .bottom, constant: insets.bottom)
        _ = addPinConstraint(addView: self, withItem: subView, toItem: self, attribute: .left, constant: insets.left)
        _ = addPinConstraint(addView: self, withItem: subView, toItem: self, attribute: .right, constant: insets.right)
    }

    public func allSafePin(subView: UIView) {
        if #available(iOS 11.0, *) {
            checkTranslatesAutoresizing(withView: subView, toView: nil)
            NSLayoutConstraint.activate([
                subView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                subView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
                subView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
                subView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            allPin(subView: subView)
        }
    }

    // MARK: NSLayoutConstraint

    public func addPinConstraint(addView: UIView, withItem:UIView, toItem:UIView?, attribute:NSLayoutConstraint.Attribute, constant:CGFloat) -> NSLayoutConstraint {
        return addConstraint(
            addView: addView,
            relation: .equal,
            withItem: withItem,
            withAttribute: attribute,
            toItem: toItem,
            toAttribute: attribute,
            constant: constant
        )
    }

    public func addWidthConstraint(view: UIView, constant:CGFloat) -> NSLayoutConstraint {
        return addConstraint(
            addView: view,
            relation: .equal,
            withItem: view,
            withAttribute: .width,
            toItem: nil,
            toAttribute: .width,
            constant: constant
        )
    }

    public func addHeightConstraint(view: UIView, constant:CGFloat) -> NSLayoutConstraint {
        return addConstraint(
            addView: view,
            relation: .equal,
            withItem: view,
            withAttribute: .height,
            toItem: nil,
            toAttribute: .height,
            constant: constant
        )
    }

    public func addConstraint(addView: UIView, relation: NSLayoutConstraint.Relation, withItem:UIView, withAttribute:NSLayoutConstraint.Attribute, toItem:UIView?, toAttribute:NSLayoutConstraint.Attribute, constant:CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(
            item: withItem,
            attribute: withAttribute,
            relatedBy: relation,
            toItem: toItem,
            attribute: toAttribute,
            multiplier: 1.0,
            constant: constant
        )

        addView.addConstraint(constraint)

        return constraint
    }

}
