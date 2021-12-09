//
//  View + ThemeFont.swift
//  Soulmate
//
//  Created by dasha on 25.11.2021.
//

import SwiftUI

public struct ThemedFont: ViewModifier {
    
    enum ThemeFont: String {
        case bold = "Montserrat-Bold"
        case black = "Montserrat-Black"
        case extraBold = "Montserrat-ExtraBold"
        case extraLight = "Montserrat-ExtraLight"
        case light = "Montserrat-Light"
        case medium = "Montserrat-Medium"
        case regular = "Montserrat-Regular"
        case semiBold = "Montserrat-SemiBold"
        case thin = "Montserrat-Thin"
    }
    
    var size: CGFloat
    var font: ThemeFont = .regular
    
    public func body(content: Content) -> some View {
        content
            .font(Font(UIFont(name: font.rawValue, size: size)!))
    }
}

extension View {
    
    public func boldFont(_ size: CGFloat) -> some View {
        self.modifier(ThemedFont(size: size, font: .bold))
    }
    
    public func mediumFont(_ size: CGFloat) -> some View {
        self.modifier(ThemedFont(size: size, font: .medium))
    }
    
    public func regularFont(_ size: CGFloat) -> some View {
        self.modifier(ThemedFont(size: size, font: .regular))
    }
}
