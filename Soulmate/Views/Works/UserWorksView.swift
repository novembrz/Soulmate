//
//  UserWorksView.swift
//  Soulmate
//
//  Created by dasha on 24.12.2021.
//

import SwiftUI

struct UserWorksView: View {
    
    @ObservedObject var viewModel: UserWorksViewModel
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            content
            moreButton
        }
        .background(Color.defaultBackground.ignoresSafeArea())
    }
    
    
    //MARK: - Content
    
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 35) {
                title
                BigTextBlock(text: viewModel.folderDescription)
                works
                seeOtherButton
            }
            .padding(.bottom, Constants.bottomInset)
            .padding(.horizontal, Constants.horizontalInset)
        }
    }
    
    
    //MARK: - Title
    
    var title: some View {
        VStack(alignment: .leading, spacing: 11) {
            TitleBlock(viewTitle: viewModel.folderNames)
            authors
        }
    }
    
    
    //MARK: - Authors
    
    var authors: some View {
        HStack(spacing: 3) {
            CustomNavigationLink {
                Image(viewModel.author)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFill()
                    .cornerRadius(10)
            } destination: {
                ProfileView(viewModel: ProfileViewModel())
            }
            
            if let coauthors = viewModel.coauthors {
                ForEach(coauthors, id: \.self) { coauthor in
                    CustomNavigationLink {
                        Image(coauthor)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .scaledToFill()
                            .cornerRadius(10)
                    } destination: {
                        ProfileView(viewModel: ProfileViewModel())
                    }
                }
            }
        }
    }
    
    
    //MARK: - Works
    
    var works: some View {
        VStack {
            if let works = viewModel.works {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: viewModel.columns, spacing: 22) {
                        ForEach(works, id: \.self) { work in
                            VStack(alignment: .leading, spacing: 7) {
                                Image(work)
                                    .resizable()
                                    .frame(height: 225)
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(15)
                                
                                HStack {
                                    Text("Анфас здания")
                                        .mediumFont(12)
                                        .foregroundColor(.blackText)
                                        .lineLimit(2)
                                    
                                    Spacer()
                                    
                                    Button {} label: {
                                        Image("more")
                                            .resizable()
                                            .frame(width: 14, height: 14)
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                Text("Нет инфы")
            }
        }
    }
    
    
    //MARK: - See Other Button

    var seeOtherButton: some View {
        CustomNavigationLink {
            LongButton(title: "Посмотреть другие проекты автора")
        } destination: {
            UserFoldersView(viewModel: UserFoldersViewModel())
        }
    }
    
    
    //MARK: - More Button
    
    var moreButton: some View {
        HStack {
            Spacer()
            
            CustomNavigationLink {
                BigStandartButton(imageName: "more")
            } destination: {
                
            }
        }
        .padding(.horizontal, Constants.horizontalInset)
    }
}


//MARK: - Previews

struct WorksView_Previews: PreviewProvider {
    static var previews: some View {
        UserWorksView(viewModel: UserWorksViewModel())
    }
}
