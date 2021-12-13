//
//  ProjectsView.swift
//  Soulmate
//
//  Created by dasha on 30.11.2021.
//

import SwiftUI

struct UserProjectsView: View {
    
    @ObservedObject var viewModel: UserProjectsViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .trailing) {
                    VStack(alignment: .trailing, spacing: 12) {
                        HStack(spacing: 12) {
                            StandartButton(imageName: "rectangles", action: viewModel.changeProjectView)
                            
                            StandartButton(imageName: "more", action: viewModel.openDetailBottomSheet)
                        }
                        StandartButton(imageName: "user", action: viewModel.routeToUserDescription)
                    }
                //}
                
                ForEach($viewModel.professionWorks, id: \.self) { work in
                    VStack(alignment: .leading, spacing: 17) {
                        ProjectCardView(userImage: "Azizova", title: work.wrappedValue, description: "Марианна Пелевина", haveProfileButton: false)
                            .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            // .padding(.top, 30)
            .padding(.bottom, 70)
            .padding(.horizontal, 26)
        }
        .background(Color.defaultBackground.ignoresSafeArea())
    }
}

struct UserProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        UserProjectsView(viewModel: UserProjectsViewModel())
        
    }
}
