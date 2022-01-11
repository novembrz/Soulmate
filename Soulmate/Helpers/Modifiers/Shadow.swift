//
//  Shadow.swift
//  Soulmate
//
//  Created by dasha on 11.01.2022.
//

import SwiftUI

extension View {
    public func elementShadow() -> some View {
        self.shadow(color: .elementShadow.opacity(0.3), radius: 30, x: 4, y: 4)
    }
    
    public func textShadow(opacity: Double = 0.3, radius: CGFloat = 2) -> some View {
        self.shadow(color: .blackText.opacity(opacity), radius: radius, x: 0, y: 0)
    }
    
    public func buttonShadow(radius: CGFloat = 25) -> some View {
        self.shadow(color: .elementShadow.opacity(0.7), radius: radius, x: 4, y: 4)
    }
}
