//
//  Extensions.swift
//  LittlePink
//
//  Created by 支天白 on 2022/7/1.
//

import Foundation

extension Bundle{
    var appName: String {
        if let appName = localizedInfoDictionary?["CFBundleDisplayName"] as? String {
            return appName
        }else{
            return infoDictionary!["CFBundleDisplayName"] as! String
        }
    }
}
