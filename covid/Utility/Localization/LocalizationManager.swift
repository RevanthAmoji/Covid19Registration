//
//  LocalizationManager.swift
//  CitygoCustomStyles
//
//  Created by Piotr Shalatonin on 9/2/20.
//  Copyright © 2020 Piotr Shalatonin. All rights reserved.
//

import UIKit

class LocalizationManager {
    static let shared = LocalizationManager()
   
    var languages: [LanguageDatasourceItem] = []
    var languageDictionary: [String: String] = [:]

    private init() {
    }

    public func loadLanguages() {
        languages = languagesItems()

        let defaultLanguageIndex = defaultSelectedIndex(items: languages)
        if defaultLanguageIndex < languages.count {
            currentLanguage = languages[defaultLanguageIndex]
        }
    }

    public var currentLanguage: LanguageDatasourceItem? {
        didSet {
            guard let unwrappedCode = currentLanguage?.title else {
                return
            }
            let resource = String(format: CitygoConstants.Localization.fileNameTemplate, unwrappedCode)
            guard let path = Bundle.main.url(forResource: resource, withExtension: nil) else {
                return
            }
            guard let dict = NSDictionary(contentsOf: path) as? [String: String] else {
                return
            }
            languageDictionary = dict
        }
    }

    private func defaultSelectedIndex(items: [LanguageDatasourceItem]) -> Int {
        var englishIndex: Int = 0
        for i in 0..<items.count {
            if items[i].title?.lowercased() == NSLocale.current.languageCode?.lowercased() {
                return i
            }
            if items[i].title?.lowercased() == CitygoConstants.Localization.defaultLanguageCode.lowercased() {
                englishIndex = i
            }
        }
        return englishIndex
    }

    func languagesItems() -> [LanguageDatasourceItem] {
        var item1 = LanguageDatasourceItem()
        item1.title = "English"
      
        var item3 = LanguageDatasourceItem()
        item3.title = "Español"
      
        let items = [item1, item3]

        return items
    }

    func stringContent(_ localizationKey: String) -> String? {
        return localize(localizationKey)
    }

    func localize(_ key: String) -> String {
        guard let translation = languageDictionary[key] else {
                return key
            }
        return translation
    }

    func apply(localizableKey key: String, for control: AnyObject) {
        switch control {
        case let label as UIKit.UILabel:
            label.text = stringContent(key)
        case let textField as UIKit.UITextField:
            textField.text = stringContent(key)
        case let textView as UIKit.UITextView:
            textView.text = stringContent(key)
        case let button as UIKit.UIButton:
            let text = stringContent(key)
            button.setTitle(text, for: .normal)
        default: break
        }
    }
        func applyBackGndColor(localizableKey key: String, for control: AnyObject) {
            switch control {
            case let button as UIKit.UIButton:
                 let backGnd = stringContent(key)
                 button.backgroundColor = UIColor.init(hex: backGnd ?? "")
            default:
                break
            }
        }

}
