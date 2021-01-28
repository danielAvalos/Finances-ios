//
//  GoogleTranslateManager.swift
//  Finances
//
//  Created by DESARROLLO on 27/01/21.
//

import Foundation
import MLKitTranslate

struct GoogleTranslateManager {

    static func translate(text: String, completionHandler: @escaping (_ text: String) -> Void) {
        let options = TranslatorOptions(sourceLanguage: .spanish, targetLanguage: .english)
            let englishGermanTranslator = Translator.translator(options: options)
        let conditions = ModelDownloadConditions(
            allowsCellularAccess: false,
            allowsBackgroundDownloading: true
        )
        englishGermanTranslator.downloadModelIfNeeded(with: conditions) { error in
            guard error == nil else { return }

            // Model downloaded successfully. Okay to start translating.
            englishGermanTranslator.translate(text) { translatedText, error in
                guard error == nil, let translatedText = translatedText else { return }
                // Translation succeeded.
                completionHandler(translatedText)
            }
        }
    }
}
