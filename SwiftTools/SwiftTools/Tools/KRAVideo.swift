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


extension URL {
    
    func addWaterMark(text: String, outFileName: String, completionHandler: @escaping (URL) -> Void) {
        if !self.isFileURL {
            debugPrint(self.absoluteString + " not is fileURL")
            return
        }
        let videoAsset = AVURLAsset(url: self, options: [AVURLAssetPreferPreciseDurationAndTimingKey:true])
        let mixComposition = AVMutableComposition()
        let videoTrack = mixComposition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        let audioTrack = mixComposition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        guard let assetVideoTrack = videoAsset.tracks(withMediaType: .video).first else {
            return print("assetVideoTrack nil")
        }
        
        guard let assetAudioTrack = videoAsset.tracks(withMediaType: .audio).first else {
            return print("assetAudioTrack nil")
        }
        
        let endTime = assetVideoTrack.asset?.duration
        do {
            try videoTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: endTime!), of: assetVideoTrack, at: .zero)
            videoTrack?.preferredTransform = assetVideoTrack.preferredTransform
            try audioTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: endTime!), of: assetAudioTrack, at: .zero)
            
            let outPath = FileManager.urlFor(directory: .cachesDirectory) + outFileName
            let outURL = URL(string: outPath)!
            print(outURL.absoluteString)
            
            let result = FileManager.default.fileExists(atPath: outURL.path)
            if result {
                try FileManager.default.removeItem(atPath: outURL.path)
                print("remove ok")
            }
            
            
            let videoSize = videoTrack!.naturalSize
            let parentLayer = CALayer()
            let videoLayer = CALayer()
            parentLayer.frame = CGRect(origin: .zero, size: videoSize)
            parentLayer.isGeometryFlipped = true
            videoLayer.frame = parentLayer.frame
            parentLayer.addSublayer(videoLayer)
            
            //            let watermarkLayer = CALayer()
            //            watermarkLayer.contents = UIImage(named: "watermark")?.cgImage
            //            watermarkLayer.frame = CGRect(x: 50, y: 100, width: 50, height: 50)
            //            parentLayer.addSublayer(watermarkLayer)
            
            let textLayer = CATextLayer()
            textLayer.string = text
            textLayer.alignmentMode = .left
            textLayer.foregroundColor = UIColor.white.cgColor
            textLayer.backgroundColor = UIColor.clear.cgColor
            textLayer.fontSize = 24
            textLayer.frame = CGRect(x: 80, y: 100, width: 150, height: 100)
            parentLayer.addSublayer(textLayer)
            
            
            let videoComp = AVMutableVideoComposition()
            videoComp.renderSize = videoSize
            videoComp.frameDuration = CMTime(value: 1, timescale: 30)
            videoComp.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, in: parentLayer)
            
            let instruction = AVMutableVideoCompositionInstruction()
            instruction.timeRange = CMTimeRange(start: .zero, duration: endTime!)
            let layerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack!)
            instruction.layerInstructions = [layerInstruction]
            videoComp.instructions = [instruction]
            
            let exporter = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)
            exporter?.outputURL = outURL
            exporter?.outputFileType = AVFileType.mov
            exporter?.shouldOptimizeForNetworkUse = true
            exporter?.videoComposition = videoComp
            exporter?.exportAsynchronously(completionHandler: {
                print(Thread.current)
                DispatchQueue.main.async {
                    completionHandler(outURL)
                }
            })
            
        } catch  {
            print(error)
        }
        
    }
}
