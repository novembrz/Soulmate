//
//  CheckboxView.swift
//  Soulmate
//
//  Created by dasha on 09.04.2022.
//

import SwiftUI


//MARK: - CheckboxGroupView

struct CheckboxGroupView: View {
    @State var variants: [String] = []
    private var columns: [GridItem] = Array(repeating: .init(.fixed(UIScreen.width / 2 - Constants.horizontalInset)), count: 2)
    
    init(variants: [String]) {
        self.variants = variants
    }
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 17) {
            ForEach(variants, id: \.self) { cell in
                CheckboxView(text: cell)
            }
        }
    }
}


//MARK: - CheckboxView

struct CheckboxView: View {
    @State var text = ""
    @State private var isChoose: Bool = false
    
    var body: some View {
        Button {
            isChoose.toggle()
        } label: {
            HStack {
                if isChoose {
                    choose
                } else {
                    notChoose
                }
                
                Text(text)
                    .foregroundColor(.blackText)
                    .mediumFont(14)
            }
        }
    }
    
    var choose: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 7)
                .frame(width: 25, height: 25)
                .foregroundColor(.mintGreen)
            
            Image(systemName: "checkmark")
                .resizable()
                .frame(width: 9, height: 9)
                .foregroundColor(.white)
                .font(.system(size: 1, weight: .bold))
        }
    }
    
    var notChoose: some View {
        RoundedRectangle(cornerRadius: 7)
            .stroke(Color.blackToWhite, lineWidth: 1)
            .frame(width: 25, height: 25)
    }
}


//MARK: - Previews

struct CheckboxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckboxGroupView(variants: ["Люди", "Работы", "Проекты"])
            .padding(.horizontal, Constants.horizontalInset)
    }
}
