//
//  KRAColorExtension.swift
//  SwiftTools
//
//  Created by zhangwei on 2018/12/21.
//  Copyright © 2018年 Kuratasx. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(hexColor: String) {
        var red:UInt32 = 0, green:UInt32 = 0, blue:UInt32 = 0
        Scanner(string: hexColor[0..<2]).scanHexInt32(&red)
        Scanner(string: hexColor[2..<4]).scanHexInt32(&green)
        Scanner(string: hexColor[4..<6]).scanHexInt32(&blue)
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
}
