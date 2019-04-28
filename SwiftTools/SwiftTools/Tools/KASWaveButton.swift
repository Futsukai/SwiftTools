//
//  KASWaveButton.swift
//  KASTimingButton
//
//  Created by zhangwei on 2019/3/6.
//  Copyright © 2019 Kuratasx. All rights reserved.
//

import UIKit

class KASWaveButton: UIButton {
    private var time: CGFloat = 0
    var depth: CGFloat = 1
    var speed: CGFloat = 0.05
    var amplitude: CGFloat = 5
    var angularVelocity: CGFloat = 1.0

    private(set) var phase: CGFloat = 0
    private(set) var displayLink: CADisplayLink?
    private(set) var whiteLayer: CALayer
    private(set) var maskLayer = CAShapeLayer()
    private(set) var completion: (()-> Void )?

    var startTimes: CFAbsoluteTime?
    var endTimes: CFAbsoluteTime?


    override init(frame: CGRect) {
        self.whiteLayer = CALayer()
        self.whiteLayer.backgroundColor = UIColor.white.cgColor
        self.whiteLayer.opacity = 0
        super.init(frame: frame)
        self.layer.addSublayer(whiteLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.whiteLayer.frame = self.bounds
    }

    func startAnimation(time: CGFloat, completion: @escaping () -> Void ) {
        self.time = time
        depth = 1
        self.isSelected = false
        self.completion = completion
        self.startAnimation()
    }

    func startAnimation() {
        self.stopAnimation()
        self.whiteLayer.opacity = 0.35
        displayLink =  CADisplayLink(target: self, selector: #selector(waving))
        displayLink?.preferredFramesPerSecond = 60
        displayLink?.add(to: RunLoop.main, forMode: .common)
        startTimes = CFAbsoluteTimeGetCurrent()
    }

    func stopAnimation() {
        self.whiteLayer.mask = nil
        self.whiteLayer.opacity = 0.0

        self.displayLink?.isPaused = true
        self.displayLink?.invalidate()
        self.displayLink = nil
    }

    @objc func waving() {
        self.phase += self.speed
        self.createPath()
    }

    func createPath() {
        if self.depth <= 0 {
            self.stopAnimation()
            /* Do a final pop animation */
            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1 / 3.0, animations: {
                    self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    self.isSelected = true
                })
                UIView.addKeyframe(withRelativeStartTime: 1 / 3.0, relativeDuration: 1 / 3.0, animations: {
                    self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                })
                UIView.addKeyframe(withRelativeStartTime: 2 / 3.0, relativeDuration: 1 / 3.0, animations: {
                    self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            }) { (completion) in
                if (self.completion != nil) {
                    self.completion?()
                }
                self.endTimes = CFAbsoluteTimeGetCurrent()
            }
            return
        }
        let path = UIBezierPath()
        let depthY = (1 - self.depth > 1.0 ? 1.0 : self.depth) * self.frame.height
        path.move(to: CGPoint(x: 0, y: depthY))
        path.lineWidth = 1.0

        var x: CGFloat = 0.0
        var y: CGFloat = 0.0
        while x <= self.frame.width {
            y = self.amplitude
                * sin(x / 180 * CGFloat.pi * self.angularVelocity + self.phase / CGFloat.pi * 4)
                + depthY
            path.addLine(to: CGPoint(x: x, y: y))
            x += 1.0
        }

        path.addLine(to: CGPoint(x: self.frame.width, y: y))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()

        maskLayer.path = path.cgPath
        whiteLayer.mask = maskLayer

        self.endTimes = CFAbsoluteTimeGetCurrent()
        let temp = endTimes! - startTimes!
        debugPrint(String(format: "time cost: %0.3f", temp))
        debugPrint(temp/Double(time))
        debugPrint("time \(time)")
        depth = 1 - 1 * CGFloat(temp/Double(time))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
