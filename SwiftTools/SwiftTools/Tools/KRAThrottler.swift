//
//  Throttler.swift
//  TestSwiftReflection
//
//  Created by zhangwei on 2019/10/24.
//  Copyright © 2019 Kuratasx. All rights reserved.
//

import Foundation

public class Throttler {
    private let queue: DispatchQueue = DispatchQueue.global(qos: .background)
    
    private var job: DispatchWorkItem = DispatchWorkItem(block: {})
    private var preiousRun: Date = Date.distantPast
    private var maxInterval: Int
    
    init(seconds: Int) {
        self.maxInterval = seconds
    }
    
    func throttle(block: @escaping ()->()) {
        job.cancel()
        job = DispatchWorkItem(){
            [weak self] in
            self?.preiousRun = Date()
            block()
        }
        let delay = Date.second(from: preiousRun) > maxInterval ? 0: maxInterval
        queue.asyncAfter(deadline: .now() + Double(delay), execute: job)
    }
}

private extension Date {
    static func second(from referenceDate: Date) -> Int {
        return Int(Date().timeIntervalSince(referenceDate).rounded())
    }
}
