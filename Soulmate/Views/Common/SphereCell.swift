//
//  SphereCell.swift
//  Soulmate
//
//  Created by dasha on 26.02.2022.
//

import SwiftUI

struct SphereCell: View {
    @State var title: String
    @State var icon: String?
    @State var isChoose: Bool = false
    @State var sphereType: SphereType
    
    enum SphereType {
        case pictureCell, checkmarkCell
    }

    
    //MARK: - Body

    var body: some View {
        HStack {
            if sphereType == .pictureCell {
                iconsCell
            } else {
                professionsRadio
            }
            
            Text(title)
                .regularFont(16)
                .foregroundColor(.blackText)
                .lineLimit(1)
        }
        .padding([.vertical, .leading], 9)
        .padding(.trailing, 20)
        .background(Color.whiteToDark)
        .cornerRadius(12)
    }
    
    
    //MARK: - Icon Cell
    
    var iconsCell: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 45, height: 45)
                .foregroundColor(.grayForElements)
            
            Text(icon!)
        }
    }
    
    
    //MARK: - Professions Radio
    
    var professionsRadio: some View {
        ZStack {
            if isChoose {
                RoundedRectangle(cornerRadius: 9)
                    .frame(width: 35, height: 35)
                    .foregroundColor(.mintGreen)
                    .elementShadow()
                    .padding(.vertical, icon == nil ? 0 : 5)
                
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.system(size: 19, weight: .bold))
            } else {
                if icon == nil {
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(Color.blackToWhite, lineWidth: 1)
                        .frame(width: 35, height: 35)
                } else {
                    iconsCell
                }
            }
        }
    }
    
}


//MARK: - Previews

struct SphereCell_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            SphereCell(title: "Музыка", icon: "🎸", isChoose: false, sphereType: .checkmarkCell)
            SphereCell(title: "Музыка", isChoose: true, sphereType: .checkmarkCell)
        }
        .padding()
        .background(Color.defaultBackground, ignoresSafeAreaEdges: .all)
    }
}
