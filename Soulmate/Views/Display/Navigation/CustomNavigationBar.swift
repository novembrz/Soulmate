//
//  CustomNavigationBar.swift
//  Soulmate
//
//  Created by dasha on 26.12.2021.
//

import SwiftUI
//Объединенный контейнер с подключенными свойствами навигейшн

struct CustomNavigationBar<Buttons: View, Content: View>: View {
    private var viewTitle: String? = ""
    private var subTitle: String? = ""
    private var viewState: NavigationViewState?
    private let content: Content
    private let buttons: Buttons?
    
    init(viewTitle: String? = "", subTitle: String? = "", viewState: NavigationViewState? = .sub, @ViewBuilder buttons: () -> Buttons, @ViewBuilder content: () -> Content) {
        self.viewTitle = viewTitle
        self.subTitle = subTitle
        self.viewState = viewState
        self.buttons = buttons()
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            CustomNavigationContainer(viewTitle: viewTitle, subTitle: subTitle, viewState: viewState) {
                buttons
            } content: {
                content
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


//MARK: - Previews

struct CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar(viewTitle: "ddddd") {
            Rectangle()
                .background(.blue)
                .frame(width: 40, height: 30)
        } content: {
            ZStack{
                Color.orange.ignoresSafeArea()
                
                Text("sdf")
            }
        }
    }
}
