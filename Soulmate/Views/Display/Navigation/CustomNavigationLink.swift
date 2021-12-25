//
//  CustomNavigationLink.swift
//  Soulmate
//
//  Created by dasha on 26.12.2021.
//

import SwiftUI

struct CustomNavigationLink<Title: View, Destination: View>: View  {
    private var viewTitle: String = ""
    private let title: Title?
    private let destination: Destination?
    
    init(viewTitle: String, @ViewBuilder title: () -> Title, @ViewBuilder destination: () -> Destination) {
        self.viewTitle = viewTitle
        self.title = title()
        self.destination = destination()
    }
    
    var body: some View {
        NavigationLink {
            CustomNavigationContainer(viewTitle: viewTitle) {} content: {
                destination
            }
            .navigationBarHidden(true)
        } label: {
            title
        }
    }
}



//MARK: - Previews

struct CustomNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar(viewTitle: "Navigation Bar") {
            Rectangle()
                .foregroundColor(.yellow)
                .frame(width: 40, height: 40)
        } content: {
            CustomNavigationLink(viewTitle: "Detail View") {
                Text("Navigation Link")
            } destination: {
                Text("Detail View for Navigation Link")
            }
        }
    }
}
