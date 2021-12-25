//
//  CustomNavigationContainer.swift
//  Soulmate
//
//  Created by dasha on 26.12.2021.
//

import SwiftUI
//Сам таб бар + контент

struct CustomNavigationContainer<Buttons: View, Content: View>: View {

    private var viewTitle: String? = ""
    private var subTitle: String?
    private var viewState: NavigationViewState? = .sub
    private let content: Content
    private let buttons: Buttons?
    
    public init(viewTitle: String? = "", subTitle: String? = "", viewState: NavigationViewState? = .sub, @ViewBuilder buttons: () -> Buttons, @ViewBuilder content: () -> Content) {
        self.viewTitle = viewTitle
        self.subTitle = subTitle
        self.viewState = viewState
        self.buttons = buttons()
        self.content = content()
    }
    
    //MARK: - Tab Bar
    
    var body: some View {
        ZStack(alignment: .top) {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            CustomNavigationView(viewTitle: viewTitle, viewState: viewState) {
                buttons
            }
            .padding(.bottom, 5)
        }
        .background(Color.gray.opacity(0.2), ignoresSafeAreaEdges: .all)
    }
    
}


//MARK: - Previews

struct CustomNavigationContainer_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationContainer(viewTitle: "CustomNavigation Container", subTitle: "CustomNavigationContainer", viewState: .sub) {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 40, height: 40)
        } content: {
            ScrollView(.vertical, showsIndicators: false) {
                Text("Content")
                    .padding(.top, 150)
            }
        }
    }
}
