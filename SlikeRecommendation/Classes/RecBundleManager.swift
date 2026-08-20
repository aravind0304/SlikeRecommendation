//
//  RecBundleManager.swift
//  CleoSDK
//
//  Created by Sanjay Singh Rathor on 09/06/21.
//

import Foundation
import UIKit

public class RecBundleManager {

    public static func frameworkBundle() -> Bundle {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: RecBundleManager.self)
        #endif
    }

    public static func path(forResource name: String?, ofType ext: String?) -> String? {
        #if SWIFT_PACKAGE
        return Bundle.module.path(forResource: name, ofType: ext)
        #else
        return frameworkBundle().path(forResource: name, ofType: ext)
        #endif
    }

    public static func image(named name: String) -> UIImage? {
        #if SWIFT_PACKAGE
        return UIImage(named: name, in: Bundle.module, compatibleWith: nil)
        #else
        let mainBundlePath = RecBundleManager.path(forResource: "SlikeRecResources", ofType: "bundle")
        let bundleFullPath = mainBundlePath?.appending("/SlikeRecommendation.bundle")
        if let bundlePath = bundleFullPath {
            let bundle = Bundle(path: bundlePath)
            return UIImage(named: name, in: bundle, compatibleWith: nil)
        }
        return nil
        #endif
    }

    public static func resourcesBundle() -> Bundle? {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        let bundle = frameworkBundle()
        let bundleUrl = bundle.url(forResource: "SlikeRecResources", withExtension: "bundle")
        if let bundleUrl = bundleUrl {
            return Bundle(url: bundleUrl)
        }
        return nil
        #endif
    }
}
