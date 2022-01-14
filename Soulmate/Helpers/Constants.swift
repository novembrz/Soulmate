//
//  Constants.swift
//  Soulmate
//
//  Created by dasha on 11.01.2022.
//

import UIKit

struct Constants {
    static let isPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
    
    static var horizontalInset: CGFloat {
        Constants.isPad ? 132 : 26 // 132 заменить
    }
    
    static var bottomInset: CGFloat {
        Constants.isPad ? 132 : 70 // 132 заменить
    }
    
    static var topInset: CGFloat {
        Constants.isPad ? 132 : 15 // 132 заменить
    }
    
    static var plugImage: String { "plug" + ["0", "1", "2", "3", "4"].randomElement()! }
}

