//
//  CustomNavigationView.swift
//  Soulmate
//
//  Created by dasha on 25.12.2021.
//

import SwiftUI
//Сам таб бар

enum NavigationViewState {
    case main, sub
}

struct CustomNavigationView<Buttons: View>: View {
    
    private var viewTitle: String? = ""
    private var subTitle: String? = ""
    private let buttons: Buttons?
    private var viewState: NavigationViewState? = .sub
    
    @Environment(\.presentationMode) var presentationMode
    
    
    //MARK: - Initional
    
    public init(viewTitle: String? = "", subTitle: String? = "", viewState: NavigationViewState? = .sub, @ViewBuilder buttons: () -> Buttons) {
        self.viewTitle = viewTitle
        self.subTitle = subTitle
        self.viewState = viewState
        self.buttons = buttons()
    }
    
    
    var body: some View {
        switch viewState {
        case .main:
            main
        case .sub:
            sub
        case .none:
            Text("")
        }
    }

    
    //MARK: - Main

    var main: some View {
        HStack(alignment: .top) {
            textBlock
            
            Spacer()
            
            buttons
        }
        .padding(.horizontal, 26)
        .padding(.top, 30)
    }
    
    
    //MARK: - Sub

    var sub: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 34) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 43, height: 43)
                            .foregroundColor(.white)
                        
                        Image(systemName: "chevron.left")
                            .resizable()
                            .frame(width: 7, height: 14)
                    }
                }
                textBlock
            }
            Spacer()
            
            buttons
        }
        .padding(.horizontal, 26)
    }
    
    
    //MARK: - Text Block
    
    var textBlock: some View {
        VStack(alignment: .leading, spacing: 10) {
            if viewTitle != "" {
            Text(viewTitle ?? "")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
            }

            if subTitle != "" {
            Text(subTitle ?? "")
                .font(.system(size: 18, weight: .regular))
                .foregroundColor(.black)
            }
        }
    }
}


//MARK: - Previews

struct CustomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView(viewTitle: "CustomNavigationView", subTitle: "ЧИсто таб бар") {
            Text("Content")
        }
        .background(Color.yellow)
    }
}
