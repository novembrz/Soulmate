//
//  BottomSheetView.swift
//  Soulmate
//
//  Created by dasha on 18.02.2022.
//

import SwiftUI


//MARK: - Constants

fileprivate enum BottomSheetConstants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 5
    static let indicatorWidth: CGFloat = 100
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0
}


//MARK: - BottomSheetView

struct BottomSheetView<Content: View>: View {
    @Binding var isOpen: Bool
    @GestureState private var translation: CGFloat = 0

    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content

    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }
    
    private var indicator: some View {
        HStack {
            Spacer()
            RoundedRectangle(cornerRadius: BottomSheetConstants.radius)
                .fill(Color.elementShadow)
                .frame(
                    width: BottomSheetConstants.indicatorWidth,
                    height: BottomSheetConstants.indicatorHeight
                ).onTapGesture {
                    self.isOpen.toggle()
                }
            Spacer()
        }
    }
    
    
    //MARK: - Initialization
    
    init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = maxHeight * BottomSheetConstants.minHeightRatio
        self.maxHeight = maxHeight
        self.content = content()
        self._isOpen = isOpen
    }
    
    
    //MARK: - Body
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if isOpen {
                    withAnimation {
                        Color.black
                            .opacity(0.5)
                            .ignoresSafeArea(.all)
                    }
                }
                
                VStack(alignment: .leading, spacing: 14) {
                    self.indicator.padding()
                    self.content
                }
                .frame(width: geometry.size.width, height: self.maxHeight, alignment: .topLeading)
                .background(Color.defaultBackground)
                .cornerRadius(BottomSheetConstants.radius)
                .frame(height: geometry.size.height, alignment: .bottom)
                .offset(y: max(self.offset + self.translation, 0))
                .animation(.interactiveSpring(), value: isOpen)
                .gesture(
                    DragGesture().updating(self.$translation) { value, state, _ in
                        state = value.translation.height
                    }.onEnded { value in
                        let snapDistance = self.maxHeight * BottomSheetConstants.snapRatio
                        guard abs(value.translation.height) > snapDistance else {
                            return
                        }
                        self.isOpen = value.translation.height < 0
                    }
                )
            }
        }
        .zIndex(99)
    }
}


//MARK: - Previews

//struct BottomSheetView_Previews: PreviewProvider {
//    static var previews: some View {
//        DisplayView()
//    }
//}
