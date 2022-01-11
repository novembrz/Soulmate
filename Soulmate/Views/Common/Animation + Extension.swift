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
