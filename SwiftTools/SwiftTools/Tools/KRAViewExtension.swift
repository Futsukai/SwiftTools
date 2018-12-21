//
//  KRAUIViewExtension.swift
//  SwiftTools
//
//  Created by zhangwei on 2018/12/21.
//  Copyright © 2018年 Kuratasx. All rights reserved.
//

import UIKit

extension UIView {
    
    var realCenter: CGPoint {
        return  self.convert(self.center, from: self.superview)
    }
    
    /// 寻找所属的控制器
    func findBelongController() -> UIViewController? {
        var tempSuperview = self.superview
        while (tempSuperview != nil) {
            let responder = tempSuperview?.next
            if (responder?.isKind(of: UIViewController.self))! {
                return responder as? UIViewController
            }
            tempSuperview = tempSuperview?.superview
        }
        return nil
    }
}
