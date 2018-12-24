//
//  KRAFileManager+StringExtension.swift
//  SwiftTools
//
//  Created by zhangwei on 2018/12/24.
//  Copyright © 2018年 Kuratasx. All rights reserved.
//

import UIKit

extension FileManager {
    
    static func urlFor(directory: FileManager.SearchPathDirectory) -> String {
        let manager = FileManager.default
        let documentURL = manager.urls(for: directory, in: .userDomainMask)
        return documentURL[0].absoluteString
    }
}


extension String {
    
    func pathIsfileExists() -> Bool{
        
        let fileManager = FileManager.default
        let result = fileManager.fileExists(atPath: URL(string: self)?.path ?? "")
        if result {
            debugPrint("have file")
            return true
        }else{
            debugPrint("no file")
            return false
        }
    }
    
    func pathSearchSuffix(suffix: String) -> [String]? {
        let contentsOfPath = try? FileManager.default.contentsOfDirectory(atPath: URL(string: self)?.path ?? "")
        return contentsOfPath?
            .filter{ $0.hasSuffix(suffix) }
            .map{ self+$0 }
    }
}

