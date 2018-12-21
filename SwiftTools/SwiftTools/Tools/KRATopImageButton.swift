//
//  KRATopImageButton.swift
//  SwiftTools
//
//  Created by zhangwei on 2018/12/21.
//  Copyright © 2018年 Kuratasx. All rights reserved.
//

import UIKit

class KRATopImageButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.textAlignment = .center
        imageView?.contentMode = .center
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: contentRect.size.height*0.7, width: contentRect.size.width, height: contentRect.size.height*0.3)
    }
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        if let size = self.currentImage?.size{
            return CGRect(x: (contentRect.size.width - size.width)*0.5, y: 0, width: size.width, height: size.height)
        }
        return CGRect.zero
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
