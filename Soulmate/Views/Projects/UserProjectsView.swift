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
            
            VStack(alignment: .leading, spacing: 34) {
                
                TitleBlock(viewTitle: viewModel.getProjectName()) {
                    moreButtons
                }
                
                switch viewModel.currentViewStyle {
                case .stroke:
                    strokeList
                case .rectangle:
                    rectangleList
                }
            }
            .padding(.bottom, 70)
            .padding(.horizontal, 26)
        }
        .background(Color.defaultBackground.ignoresSafeArea())
    }
    
    
    //MARK: - More Buttons
    
    var moreButtons: some View {
        VStack(alignment: .trailing, spacing: 12) {
            HStack(spacing: 12) {
                StandartButton(imageName: viewModel.currentViewStyle == .stroke ? "rectangles" : "lines", action: viewModel.changeProjectView)
                
                StandartButton(imageName: "more", action: viewModel.openDetailBottomSheet)
            }
            StandartButton(imageName: "user", action: viewModel.routeToUserDescription)
        }
    }
    
    
    //MARK: - List
    
    var strokeList: some View {
        VStack(alignment: .leading, spacing: 17) {
            ForEach($viewModel.professionWorks, id: \.self) { work in
                ProjectStrokeCardView(title: work.wrappedValue, description: "Марианна Пелевина", projectImages: viewModel.projectImages, haveProfileButton: false)
            }
        }
    }
    
    var  rectangleList: some View {
        VStack(spacing: 17) {
            ForEach($viewModel.professionWorks, id: \.self) { work in
                ProjectRectangleCardView(title: work.wrappedValue, description: "Марианна Пелевина", projectImages: viewModel.projectImages)
            }
        }
    }
}


//MARK: - Previews

struct UserProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        UserProjectsView(viewModel: UserProjectsViewModel())
    }
}
