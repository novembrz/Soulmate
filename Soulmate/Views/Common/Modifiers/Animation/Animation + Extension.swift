//
//  Animation + Extension.swift
//  Soulmate
//
//  Created by dasha on 03.12.2021.
//

import SwiftUI

extension Animation {
    static func goodRipple() -> Animation {
        Animation.spring(dampingFraction: 0.5) // как пружина чуть больше своего размера и отрекошетила в нужный
            //.speed(2) //быстрее
           
    }
    
    static func ripple(index: Int) -> Animation { //Добавьте задержку к каждой анимации, основанную на index капсулы на графике.
        Animation.spring(dampingFraction: 0.5)
            .speed(2)
            .delay(0.03 * Double(index))
    }
    
    static func startingRipple(delay: Double = 0, speed: Double = 1) -> Animation { // как пружина чуть больше своего размера и отрекошетила в нужный
        Animation.spring(dampingFraction: 0.5)
            .delay(delay)
            .speed(speed) //быстрее
    }
    
    static func navigationAnimation() -> Animation {
        Animation.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)
    }
}

extension View {
    func appearAnimation(animation: Animation , _ action: @escaping () -> Void) -> some View {
        onAppear {
            withAnimation(animation) {
                action()
            }
        }
    }
}

//для чистого кода - вызов чище
extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .move(edge: .trailing)
    }
    
    static var opacityAndSlide: AnyTransition {
        .asymmetric(insertion: .opacity, removal: .slide) //вкл на opacity выкл на slide
    }
    
    static var trailingOpacityAndScaleOpacity: AnyTransition {
            .asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .scale.combined(with: .opacity)
            )
        }
}
