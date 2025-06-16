//
//  LanguageManager.swift
//  Unsolved
//
//  Created by Margot Pasquali on 12/06/2025.
//

import Foundation

final class LanguageManager {
    static let shared = LanguageManager()
    
    func getLanguageKey() -> String {
        let systemLanguage = Locale.current.languageCode ?? "en"
        let supportedLanguages = ["en", "fr"]
        return supportedLanguages.contains(systemLanguage) ? systemLanguage : "en"
    }
}
