//
//  CustomNavigationLink.swift
//  Soulmate
//
//  Created by dasha on 10.01.2022.
//

import SwiftUI


struct CustomNavigationLink<Title: View, Destination: View>: View {
    
    private let destination: Destination
    private let title: Title?
    
    init(@ViewBuilder title: () -> Title?, @ViewBuilder destination: () -> Destination) {
        self.title = title()
        self.destination = destination()
    }
    
    var body: some View {
        NavigationLink {
            ZStack(alignment: .topLeading) {
                destination
                
                BackButton()
                    .padding(.leading, Constants.horizontalInset)
            }
            .navigationBarHidden(true)
        } label: {
            title
        }
    }
}
