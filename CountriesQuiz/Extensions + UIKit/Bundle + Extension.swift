//
//  Bundle + Extension.swift
//  CountriesQuiz
//
//  Created by Marat Shagiakhmetov on 31.01.2025.
//

import Foundation

private var bundleKey: Int8 = 0

final class BundleEx: Bundle, @unchecked Sendable {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        guard let bundle = objc_getAssociatedObject(self, &bundleKey) as? Bundle else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        return bundle.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {
    static func setLanguage(_ language: String) {
        object_setClass(Bundle.main, BundleEx.self)
        let path = Bundle.main.path(forResource: language, ofType: "lproj") ?? Bundle.main.path(forResource: "en", ofType: "lproj")!
        objc_setAssociatedObject(Bundle.main, &bundleKey, Bundle(path: path), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
