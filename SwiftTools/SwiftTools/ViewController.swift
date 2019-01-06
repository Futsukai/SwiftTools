//
//  ViewController.swift
//  SwiftTools
//
//  Created by zhangwei on 2018/12/21.
//  Copyright © 2018年 Kuratasx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var test:UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            .addSelector(action: #selector(hello), for: .touchDown)
        btn.backgroundColor = .red
        self.view.addSubview(btn)
        
        let l = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        l.text = "AAAAAAAA"
//        l.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(l)
        
        test = l
        
        print(UIScreen.main.scale)
        print(UIScreen.main.nativeScale)
        print(UIScreen.main.bounds)
        print(UIScreen.main.coordinateSpace)

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(test?.font)
        
    }
    @objc func hello() {
        print("---------->> \(self).\(#function)<<---------")
    }



}

