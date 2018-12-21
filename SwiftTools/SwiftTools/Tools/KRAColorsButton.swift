//
//  KRAColorsButton.swift
//  SwiftTools
//
//  Created by zhangwei on 2018/12/21.
//  Copyright © 2018年 Kuratasx. All rights reserved.
//

import UIKit

/// 渐变色按钮,
class KRAColorsButton: UIButton {

    lazy var gradient: CAGradientLayer = {
        let g = CAGradientLayer()
        return g
    }()
    
    private lazy var colors =  [ String:[CGColor] ]()
    private var cornerRadiusRate: CGFloat = 1.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        if colors.count == 0 {
            fatalError("colors must have one State.normal Color!")
        }
        
        if colors[String(self.state.rawValue)] == nil {
            self.gradient.colors = colors[String(UIControl.State.normal.rawValue)]
        } else {
            self.gradient.colors = colors[String(self.state.rawValue)]
        }
        
        self.gradient.frame = self.bounds
        self.gradient.cornerRadius = self.bounds.height / 2 * cornerRadiusRate
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    /// 设置按钮在某种状态时的渐变颜色, 渐变方向为 左—>右
    func setGradient(colors:[CGColor], cornerRadiusRate:CGFloat, for state: UIControl.State) {
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        self.cornerRadiusRate = cornerRadiusRate
        self.colors[String(state.rawValue)] = colors
    }

}
