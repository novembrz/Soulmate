//
//  UserWorksView.swift
//  Soulmate
//
//  Created by dasha on 24.12.2021.
//

import SwiftUI

struct UserWorksView: View {
    
    @State var folderId: Int
    @ObservedObject var viewModel: UserWorksViewModel
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            content
            moreButton
        }
        .background(Color.defaultBackground.ignoresSafeArea())
        .onAppear {
            viewModel.fetchWorks(folderId)
        }
    }
    
    
    //MARK: - Content
    
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 35) {
                title
                
                if viewModel.works != []  {
                    BigTextBlock(text: viewModel.folderDescription)
                    works
                    seeOtherButton
                } else {
                    Image("worksPlug")
                        .resizable()
                        .scaledToFit()
                }
            }
            .padding(.top, Constants.topInset)
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
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
                    .cornerRadius(10)
            } destination: {
                //ProfileView(userId: <#T##Int#>, viewModel: <#T##ProfileViewModel#>)
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
                       // ProfileView(viewModel: ProfileViewModel())
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
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 225)
                                    .frame(minWidth: 125, maxWidth: 170, alignment: .center)
                                    .clipped()
                                    .cornerRadius(15)
                                
                                HStack {
                                    Text("Анфас здания")
                                        .mediumFont(14)
                                        .foregroundColor(.blackText)
                                        .lineLimit(2)
                                    
                                    Spacer()
                                    
                                    Button {} label: {
                                        Image("more")
                                            .resizable()
                                            .frame(width: 14, height: 14)
                                            .foregroundColor(.mintGreen)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    //MARK: - See Other Button

    var seeOtherButton: some View {
        CustomNavigationLink {
            LongButton(title: "Посмотреть другие проекты автора")
        } destination: {
            FoldersView(viewModel: FoldersViewModel())
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
        .padding(.top, Constants.topInset)
        .padding(.horizontal, Constants.horizontalInset)
    }
}


//MARK: - Previews

struct WorksView_Previews: PreviewProvider {
    static var previews: some View {
        UserWorksView(folderId: 1, viewModel: UserWorksViewModel())
            .preferredColorScheme(.dark)
    }
}
