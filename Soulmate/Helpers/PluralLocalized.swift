//
//  String Extension + Localized.swift
//  Soulmate
//
//  Created by dasha on 27.11.2021.
//

import SwiftUI

extension String {
    func pluralLocalized(number: Int) -> String {
        return PluralLocalized().pluralDictLocalized(number: number, word: self)
    }
}

final class PluralLocalized {
    
    let pluralDict: [String:[String]] = [
        "работа": ["работа", "работы", "работ"]
    ]
    
    func pluralDictLocalized(number: Int, word: String) -> String {
            if let strings = pluralDict[word] {
                return pluralRuForm(number: number, forms: strings)
            }
            return word
    }
    
    func pluralRuForm(number: Int, forms: [String]) -> String {
        return number % 10 == 1 && number % 100 != 11 ? forms[0] :
            (number % 10 >= 2 && number % 10 <= 4 && (number % 100 < 10 || number % 100 >= 20) ? forms[1] : forms[2])
    }
}
