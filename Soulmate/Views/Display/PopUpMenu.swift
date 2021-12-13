//
//  PopUpMenu.swift
//  Soulmate
//
//  Created by dasha on 10.12.2021.
//

import SwiftUI

struct PopUpMenu: View {
    
    @State var menu = ["Project", "Photo", "Audio", "Text"]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack(spacing: 28) {
                ForEach($menu, id: \.self) { item in
                    Circle()
                        .frame(width: 37, height: 37)
                        .foregroundColor(.mintGreen)
                }
            }
        }
    }
}

struct PopUpMenu_Previews: PreviewProvider {
    static var previews: some View {
        PopUpMenu()
    }
}
