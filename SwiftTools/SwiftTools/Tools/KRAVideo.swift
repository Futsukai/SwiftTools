//
//  KRAVideo.swift
//  SwiftTools
//
//  Created by zhangwei on 2019/1/3.
//  Copyright © 2019年 Kuratasx. All rights reserved.
//

import UIKit
import AVFoundation

class KRAVideo {
    
    /// 截取视频的time帧数 CMTime value是帧数  timescale 是帧速
    func getThunbImage(url: URL, time: CMTime) -> (UIImage) {
        let asset: AVURLAsset = AVURLAsset(url: url, options: nil)
        let gen: AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
        // 确保截图的方向正确
        gen.appliesPreferredTrackTransform = true
        // 由于缓存的存在，设为zero确保截图准确
        gen.requestedTimeToleranceAfter = .zero
        gen.requestedTimeToleranceBefore = .zero
        var actualTime: CMTime = CMTime()
        var thumb: UIImage = UIImage()
        do {
//            CMTimeShow(actualTime)
            let image: CGImage = try gen.copyCGImage(at: time, actualTime: &actualTime)
            thumb = UIImage(cgImage: image)
        } catch {
            
        }
        return thumb
    }
}
