//
//  LocalizationLayer.swift
//  ThmanyahPodcasts
//
//  Created by Mahmoud Allam on 23/11/2023.
//

import Foundation
import UIKit
// swiftlint:disable force_unwrapping discouraged_direct_init superfluous_disable_command force_cast

enum ApplicationLanguage: String {
    case arabic = "ar"
    case english = "en"
}

class LocalizationManager {
    private let appLanguagesKey = "AppleLanguages"

    init() {}

    static let shared = LocalizationManager()

    func currentLanguage() -> ApplicationLanguage {
        let def = UserDefaults.standard
        let currentLanguages = def.object(forKey: appLanguagesKey) as! NSArray
        let fristString = currentLanguages.firstObject as! String
        return fristString.contains(ApplicationLanguage.arabic.rawValue) ? .arabic : .english
    }

    func setAppLanguage(lang: ApplicationLanguage) {
        let def = UserDefaults.standard
        def.set([lang.rawValue, currentLanguage().rawValue], forKey: appLanguagesKey)
        def.synchronize()
        var semanticAttribute: UISemanticContentAttribute = .unspecified
        if lang == .arabic {
            semanticAttribute = .forceRightToLeft
        } else {
            semanticAttribute = .forceLeftToRight
        }
        UIView.appearance().semanticContentAttribute = semanticAttribute
        UITabBar.appearance().semanticContentAttribute = semanticAttribute
    }

    func checkLanguageDirection() -> UISemanticContentAttribute {
        switch currentLanguage() {
        case .arabic:
            return .forceRightToLeft
        case .english:
            return .forceLeftToRight
        }
    }

    func isAppInArabicLanguage() -> Bool {
        currentLanguage() == .arabic
    }

    func isAppInEnglishLanguage() -> Bool {
        currentLanguage() == .english
    }

    func DoTheExchange() {
        ExchangeMethodsForClass(ClassName: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.customLocalizedStringForKey(_:value:table:)))
    }

    // Method to change implementation of an Method for Class
    private func ExchangeMethodsForClass(ClassName: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
        let originalMethod: Method = class_getInstanceMethod(ClassName, originalSelector)!
        let overRideMethod: Method = class_getInstanceMethod(ClassName, overrideSelector)!
        if class_addMethod(ClassName, originalSelector, method_getImplementation(overRideMethod), method_getTypeEncoding(overRideMethod)) {
            class_replaceMethod(ClassName, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, overRideMethod)
        }
    }
}

extension String {
    var localize: String {
        NSLocalizedString(self, comment: "")
    }
}

extension Bundle {
    @objc func customLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
        let currentLanguage = LocalizationManager.shared.currentLanguage()
        var bundle = Bundle()
        if let path = Bundle.main.path(forResource: currentLanguage.rawValue, ofType: "lproj") {
            bundle = Bundle(path: path)!
        } else {
            let path = Bundle.main.path(forResource: "Base", ofType: "lproj")
            bundle = Bundle(path: path!)!
        }
        return bundle.customLocalizedStringForKey(key, value: value, table: tableName)
    }
}
