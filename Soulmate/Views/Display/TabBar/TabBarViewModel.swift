//
//  TabBarViewModel.swift
//  Soulmate
//
//  Created by dasha on 10.12.2021.
//

import SwiftUI

final class TabBarViewModel: ObservableObject {
    @Published var startAnimation: Bool = false
    @Published var size: CGSize
    @Published var bottomEdje: CGFloat
    @Published var animation: Namespace.ID
    
    var animationOffset: CGFloat { (startAnimation ? (startAnimation ? 15 : 18) : (bottomEdje == 0 ? 26 : 27)) }
    var offset: CGSize { bottomEdje == 0 ?
    CGSize(width: animationOffset, height: 31) :
        CGSize(width: animationOffset, height: 36) }
    
    
    init(size: CGSize, bottomEdje: CGFloat, animation: Namespace.ID) {
        self.size = size
        self.bottomEdje = bottomEdje
        self.animation = animation
    }
    
    
    //Shape
    func getStartOffset() -> CGFloat {
        let reduced = (size.width - 30) / 5
        let center = (reduced - 45) / 2
        return center
    }
    
    //Палка под кругом
    func getOffset(currentTab: AnimateTab) -> CGFloat {
        let reduced = (size.width - 32) / 5
        let index = AnimateTab.allCases.firstIndex { checkTab in
            return checkTab == currentTab
        } ?? 0
        return reduced * CGFloat(index)
    }
}
