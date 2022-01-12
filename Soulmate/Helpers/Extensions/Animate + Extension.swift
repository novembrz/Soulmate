//
//  Animate + Extension.swift
//  Soulmate
//
//  Created by dasha on 05.12.2021.
//

import SwiftUI

extension View {
    func appearAnimation(animation: Animation , _ action: @escaping () -> Void) -> some View {
        onAppear {
            withAnimation(animation) {
                action()
            }
        }
    }
}


extension Animation {
    static func startingRipple(delay: Double = 0, speed: Double = 1) -> Animation { // как пружина чуть больше своего размера и отрекошетила в нужный
        Animation.spring(dampingFraction: 0.5)
            .delay(delay)
            .speed(speed) //быстрее
    }
    
    static func navigationAnimation() -> Animation {
        Animation.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)
    }
}
