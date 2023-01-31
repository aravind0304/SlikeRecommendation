//
//  RecBundleManager.swift
//  CleoSDK
//
//  Created by Sanjay Singh Rathor on 09/06/21.
//

import Foundation
public class RecBundleManager {
    
    /// - Returns: Bundle
    public static func frameworkBundle() -> Bundle {
        let bundle = Bundle(for: self)
        return bundle
    }
    
    /// - Parameters:
    ///   - name: Resource Name
    ///   - ext: Resource Type
    /// - Returns: path
    public static func path(forResource name: String?, ofType ext: String?) -> String? {
        let bundle = frameworkBundle()
        let path = bundle.path(forResource: name, ofType: ext)
        return path
    }
    
    /// Resource picture
    ///
    /// - Parameter name: image name
    /// - Returns: image
    public static func image(named name: String) -> UIImage? {
        let mainBundlePath = RecBundleManager.path(forResource: "SlikeRecResources", ofType: "bundle")
        let bundleFullPath = mainBundlePath?.appending("/SlikeRecommendation.bundle")
        if let bundlePath = bundleFullPath {
            let bundle = Bundle(path: bundlePath)
            return UIImage(named: name, in: bundle, compatibleWith: nil)
        }
        return nil
    }
    
    public static func resourcesBundle() -> Bundle? {
        let bundle = RecBundleManager.frameworkBundle()
        let bunldeUrl = bundle.url(forResource: "SlikeRecResources", withExtension: "bundle")
        if let bundleUrl = bunldeUrl {
            let bundle = Bundle(url: bundleUrl)
            return bundle
        }
        return nil
    }
}
