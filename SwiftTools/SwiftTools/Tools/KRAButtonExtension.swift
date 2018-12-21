//
//  KRAButtonExtension.swift
//  SwiftTools
//
//  Created by zhangwei on 2018/12/21.
//  Copyright © 2018年 Kuratasx. All rights reserved.
//

import UIKit

/// UIButton链式封装
extension UIButton {
    
    func fontSize(_ size: CGFloat) -> Self {
        self.titleLabel?.font = UIFont.systemFont(ofSize: size)
        return self
    }
    
    func fontSize(_ size: CGFloat,for fontName: String) -> Self {
        self.titleLabel?.font = UIFont(name: fontName, size: size)
        return self
    }
    
    func titleString(_ title: String, for state: UIControl.State) -> Self {
        self.setTitle(title, for: state)
        return self
    }
    
    func titleString(_ title: String, color: UIColor, for state: UIControl.State ) -> Self {
        self.setTitle(title, for: state)
        self.setTitleColor(color, for: state)
        return self
    }
    
    func borderStyle(color: UIColor, width: CGFloat) -> Self {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
        return self
    }
    
    func cornerRadius(_ radius: CGFloat) -> Self {
        self.layer.cornerRadius = radius
        return self
    }
    
    func isEnabled(_ enabled: Bool,and alpha: CGFloat) -> Self {
        self.isEnabled = enabled
        if enabled {
            self.alpha = 1
        }else{
            self.alpha = alpha
        }
        return self
    }
    
    func imageName(_ image: String, for state: UIControl.State) -> Self {
        self.setImage(UIImage(named: image), for: state)
        return self
    }
    
    /// target 传nil的话,会自动在相应链中搜索相应的方法,所以可以正常工作
    func addSelector(action: Selector,for controlEvents: UIControl.Event) -> Self {
        self.addTarget(nil, action: action, for: controlEvents)
        return self
    }
    
    
    func end() {}
    
}
