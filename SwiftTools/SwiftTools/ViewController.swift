//
//  ViewController.swift
//  SwiftTools
//
//  Created by zhangwei on 2018/12/21.
//  Copyright © 2018年 Kuratasx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            .addSelector(action: #selector(hello), for: .touchDown)
        btn.backgroundColor = .red
        self.view.addSubview(btn)
    }
    @objc func hello() {
        print("---------->> \(self).\(#function)<<---------")
    }



}

