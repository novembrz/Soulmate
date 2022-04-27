//
//  CheckboxView.swift
//  Soulmate
//
//  Created by dasha on 09.04.2022.
//

import SwiftUI


//MARK: - CheckboxGroupView

struct CheckboxGroupView: View {
    @State var checkbox: [CheckboxModel]
    @State var selectedCheckbox: Set<String> = []
    @Binding var deleteAll: Bool
    
    let callback: ([String]) -> ()
    
    var columns: [GridItem] = Array(repeating: .init(.fixed(UIScreen.width / 2 - Constants.horizontalInset)), count: 2)
    
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 17) {
            ForEach(checkbox, id: \.self) { checkbox in
                CheckboxView(checkbox: checkbox, deleteAll: $deleteAll) { filter in
                    if filter.isChoose {
                        self.selectedCheckbox.insert(filter.filterName)
                    } else {
                        self.selectedCheckbox.remove(filter.filterName)
                    }
                }
            }
        }
        .onChange(of: deleteAll) { _ in
            selectedCheckbox.removeAll()
        }
        .onChange(of: selectedCheckbox) { newValue in
            let array = Array(selectedCheckbox)
            callback(array)
        }
    }
}


//MARK: - CheckboxView

struct CheckboxView: View {
    @State var checkbox: CheckboxModel
    @Binding var deleteAll: Bool
    let callback: (CheckboxModel) -> ()
    
    var body: some View {
        Button {
            checkbox.isChoose.toggle()
            self.callback(checkbox)
        } label: {
            HStack {
                if checkbox.isChoose {
                    choose
                } else {
                    notChoose
                }
                
                Text(checkbox.title)
                    .foregroundColor(.blackText)
                    .mediumFont(14)
            }
        }
        .onChange(of: deleteAll) { _ in
            if deleteAll {
                DispatchQueue.main.async {
                    checkbox.isChoose = false
                    deleteAll = false
                }
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
//
//struct CheckboxView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckboxGroupView(
//            checkbox: [
//                CheckboxModel(title: "Люди", filterName: SearchCategory.user.rawValue),
//                CheckboxModel(title: "Работы", filterName: SearchCategory.card.rawValue),
//                CheckboxModel(title: "Проекты", filterName: SearchCategory.folder.rawValue)
//            ])
//        .padding(.horizontal, Constants.horizontalInset)
//    }
//}
