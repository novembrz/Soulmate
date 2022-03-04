//
//  LinearGradient + Extension.swift
//  Soulmate
//
//  Created by dasha on 20.02.2022.
//

import SwiftUI

extension LinearGradient {
    public static var horizontalGradient = LinearGradient(colors: [.lightPurple, .turquoise], startPoint: .leading, endPoint: .trailing)
    public static var diagonalGradient = LinearGradient(colors: [.lightPurple, .turquoise], startPoint: .topLeading, endPoint: .bottomTrailing)
}
