//
//  HomeView.swift
//  Soulmate
//
//  Created by dasha on 29.11.2021.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @State var appears = false
    
    var body: some View {
        CustomNavigationView {
            RefreshableScrollView(refreshing: $viewModel.refreshing) {
                ZStack {
                    if viewModel.isInternetConnected {
                        homePage
                    } else {
                        InternetConnectionView()
                    }
                }
            }
            .background(Color.defaultBackground.ignoresSafeArea())
            .onAppear(perform: {
                if !appears {
                    appears = !appears
                } else {
                    viewModel.fetchHomePage()
                }
            })
            .showLoading(isShowing: $viewModel.isLoading)
            .onChange(of: viewModel.refreshing ) { newValue in
                viewModel.fetchHomePage(type: .refreshing)
            }
        }
    }
    
    
    //MARK: - home page
    
    var homePage: some View {
        VStack(alignment: .leading, spacing: 8) {
            title
            
            VStack(alignment: .leading, spacing: 25) {
                HStack(spacing: 11) {
                    SearchView(viewModel: viewModel)
                    filterButton
                }
                .padding(.horizontal, Constants.horizontalInset)
                
                VStack(spacing: 48) {
                    sphere
                    suitableUsers
                    folders
                    works
                }
            }
            
        }
        .padding(.top, 30)
        .padding(.bottom, Constants.bottomInset)
    }
    
    
    //MARK: - title
    
    var title: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Поиск")
                .boldFont(25)
                .foregroundColor(.blackText)
            
            Text("По всем интересам".lowercased())
                .regularFont(18)
                .foregroundColor(.blackText)
        }
        .padding(.horizontal, Constants.horizontalInset)
    }
    
    
    //MARK: - filter Button
    
    var filterButton: some View {
        VStack {
            CustomNavigationLink {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.mintGreen)
                        .frame(width: 37, height: 47)
                    
                    Image("filter")
                        .resizable()
                        .frame(width: 14, height: 18)
                        .foregroundColor(.whiteText)
                }
            } destination: {
                FiltersView(viewModel: FiltersViewModel())
            }
        }
    }
    
    
    //MARK: - sphere
    
    var sphere: some View {
        ContentBlock(title: "Сферы") {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 11) {
                    ForEach(viewModel.professionalSpheres, id: \.self) { sphere in
                        Button {} label: {
                            SphereCell(title: sphere.sphereName,
                                       icon: sphere.icon,
                                       sphereType: .pictureCell)
                        }
                    }
                }
                .padding(.horizontal, Constants.horizontalInset)
            }
            .elementShadow()
        } destination: {}
    }
    
    
    //MARK: - suitable users
    
    var suitableUsers: some View {
        ContentBlock(title: "Из твоей среды", buttonTitle: "Все") {
            VStack(spacing: Constants.horizontalInset) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 11) {
                        ForEach(viewModel.suitableUsers, id: \.self) { user in
                            CustomNavigationLink {
                                ContentCard(name: user.firstName ?? "",
                                            id: user.id,
                                            lastName: user.lastName,
                                            description: user.professions?
                                                .filter { $0.main }
                                                .first?.name ?? "",
                                            imageString: user.avatars?
                                                .filter { $0.main ?? false }
                                                .first?.link ?? "",
                                            contentType: .user,
                                            minWidth: 135, maxWidth: 135
                                )
                            } destination: {
                                ProfileView(userId: user.id,
                                            viewModel: ProfileViewModel())
                            }
                        }
                        seeAllUser
                    }
                    .padding(.horizontal, Constants.horizontalInset)
                }
                
                LongButton(title: "Найти на карте", iconName: "map")
                    .padding(.horizontal, Constants.horizontalInset)
            }
        } destination: {
            SuitableUsersView(viewModel: SuitableUsersViewModel())
        }
    }
    
    
    //MARK: - seeAllUser
    
    var seeAllUser: some View {
        CustomNavigationLink {
            VStack(spacing: 15) {
                Text("А можно всех посмотреть?")
                    .boldFont(14)
                    .foregroundColor(.whiteText)
                    .multilineTextAlignment(.center)
                    .frame(width: 100)
                
                Image("seeAll")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 46)
                    .foregroundColor(.whiteText)
            }
            .frame(width: 135, height: 195)
            .background(Color.mintGreen)
            .cornerRadius(15)
        } destination: {
            SuitableUsersView(viewModel: SuitableUsersViewModel())
        }
    }
    
    
    //MARK: - folders
    
    var folders: some View {
        ContentBlock(title: "Проекты", buttonTitle: "Все") {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: viewModel.folderColumns, alignment: .top, spacing: 18) {
                    ForEach(viewModel.suitableFolders, id: \.self) { folder in
                        CustomNavigationLink {
                            FolderStrokeCardView(folder: folder, haveProfileButton: true)
                        } destination: {
                            UserWorksView(folderId: folder.id, viewModel: UserWorksViewModel())
                        }
                    }
                }
                .padding(.horizontal, Constants.horizontalInset)
            }
        }  destination: {
            FoldersView(viewModel: FoldersViewModel())
        }
    }
    
    
    //MARK: - works
    
    var works: some View {
        ContentBlock(title: "Топ работ") {
            LazyVGrid(columns: viewModel.cardColumns, spacing: 18) {
                ForEach(viewModel.suitableCards, id: \.self) { card in
                    ContentCard(name: card.name,
                                id: card.id,
                                description: (card.author.firstName ?? "") + " " + (card.author.lastName ?? ""),
                                imageString: card.picture ?? "",
                                contentType: .work,
                                height: 137,
                                smallText: true)
                }
            }
            .padding(.horizontal, Constants.horizontalInset)
        } destination: {}
    }
}


//MARK: - MainView_Previews

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
       //DisplayView()
        Group {
            HomeView(viewModel: HomeViewModel())
                .preferredColorScheme(.light)
            HomeView(viewModel: HomeViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
