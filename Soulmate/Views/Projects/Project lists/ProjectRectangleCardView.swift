//
//  ProjectRectangleCardView.swift
//  Soulmate
//
//  Created by dasha on 23.12.2021.
//

import SwiftUI

struct ProjectRectangleCardView: View {
    var title: String
    var description: String
    var coauthorCount: Int?
    var projectImages: [String]?
    var projectImagesCount: Int { projectImages?.count ?? 0 }
    //var profileId and projectId
    @State var showProject = false
    
    var body: some View {
        Button {
            showProject = true
        } label: {
            VStack(spacing: 9) {
                previewImages
                projectDescription
            }
        }
    }
    
    
    //MARK: - Preview Images

    var previewImages: some View {
        HStack(spacing: 2) {
            if projectImages != nil {
                if let image = projectImages?[0] {
                    Image(image)
                        .resizable()
                        .scaledToFill()
                }
                
                VStack(spacing: 2) {
                    if projectImagesCount > 1 {
                        Image(projectImages?[1] ?? "")
                            .resizable()
                            .frame(width: 100)
                            .frame(height: projectImagesCount > 2 ? 85 : .infinity)
                    }
                    
                    if projectImagesCount > 2 {
                        Image(projectImages?[2] ?? "")
                            .resizable()
                            .frame(width: 100)
                            .frame(height: 85)
                    }
                }
                
            } else {
                Rectangle()
                    .background(Color.red)
            }
        }
        .frame(height: 170)
        .cornerRadius(15)
        .fullScreenCover(isPresented: $showProject) {
            UserWorksView(viewModel: UserWorksViewModel())
        }
    }

    
    //MARK: - Project Description

    var projectDescription: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .boldFont(14)
                    .foregroundColor(.blackText)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                HStack(spacing: 4) {
                    Text(description)
                        .regularFont(11)
                        .foregroundColor(.blackText)
                    
                    if coauthorCount != nil {
                        Text("+ \(coauthorCount ?? 0)")
                            .regularFont(11)
                            .foregroundColor(.blackText)
                    }
                }
            }
            
            Spacer()
            
            Button {
                // alert
            } label: {
                Image("more")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.blackText)
                    .padding(.trailing, 6)
            }
        }
    }
}


//MARK: - Previews

struct ProjectRectangleCardView_Previews: PreviewProvider {
    static var previews: some View {
        UserProjectsView(viewModel: UserProjectsViewModel())
    }
}
