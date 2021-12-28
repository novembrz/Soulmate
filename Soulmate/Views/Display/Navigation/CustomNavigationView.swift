//
//  CustomNavigationView.swift
//  Soulmate
//
//  Created by dasha on 27.12.2021.
//

import SwiftUI


struct CustomNavigationView<Content: View>: View {
    
    private let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


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
                    .padding(.leading, 26)
            }
            .navigationBarHidden(true)
        } label: {
            title
        }
    }
}



struct NavView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView {
            VStack(spacing: 40) {
                Text("Home page")
                
                CustomNavigationLink {
                    Text("Tap")
                } destination: {
                    ScrollView(.vertical, showsIndicators: false) {
                        Text("Destination View Controller")
                            .padding(.top, 40)
                    }
                    
                }
            }
        }
    }
}
