//
//  HomeView.swift
//  Soulmate
//
//  Created by dasha on 29.11.2021.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        CustomNavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 8) {
                    title
                    
                    VStack(alignment: .leading, spacing: 25) {
                        HStack(spacing: 11) {
                            SearchView(viewModel: SearchViewModel())
                            filterButton
                        }
                        .padding(.horizontal, viewModel.screenOffset)
                        
                        VStack(spacing: 48) {
                            sphere
                            environment
                            folders
                            works
                        }
                    }
                }
                .padding(.top, 30)
                .padding(.bottom, 70)
            }
            .background(Color.defaultBackground.ignoresSafeArea())
            .onAppear { viewModel.fetchHomePage() }
        }
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
        .padding(.horizontal, viewModel.screenOffset)
    }
    
    
    //MARK: - filterButton
    
    var filterButton: some View {
        VStack {
            Button {} label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.mintGreen)
                        .frame(width: 37, height: 47)
                    
                    Image("filter")
                        .resizable()
                        .frame(width: 14, height: 18)
                }
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
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 45, height: 45)
                                        .foregroundColor(.grayForElements)
                                    
                                    Text(sphere.icon)
                                }
                                
                                Text(sphere.sphereName)
                                    .regularFont(16)
                                    .foregroundColor(.blackText)
                            }
                            .padding([.vertical, .leading], 9)
                            .padding(.trailing, 20)
                            .background(Color.whiteToDark)
                            .cornerRadius(15)
                        }
                    }
                }
                .padding(.horizontal, viewModel.screenOffset)
            }
            .shadow(color: .elementShadow.opacity(0.3), radius: 30, x: 4, y: 4)
        } destination: {}
    }
    
    
    //MARK: - environment
    
    var environment: some View {
        ContentBlock(title: "Из твоей среды", buttonTitle: "Все") {
            VStack(spacing: viewModel.screenOffset) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 11) {
                        ForEach(viewModel.suitableUsers, id: \.self) { user in
                            CustomNavigationLink {
                                ContentCard(name: user.firstName,
                                            description: user.userProfessions?
                                                .filter { $0.main }
                                                .first?.name ?? "",
                                            imageString: user.avatars?
                                                .filter { $0.main }
                                                .first?.link ?? "")
                                    .frame(width: 135)
                            } destination: {
                                ProfileView(viewModel: ProfileViewModel())
                            }
                        }
                        seeAllUser
                    }
                    .padding(.horizontal, viewModel.screenOffset)
                }
                
                LongButton(title: "Найти на карте", iconName: "map") {
                    print("")
                }
            }
        } destination: {
            ProfileView(viewModel: ProfileViewModel())
        }
    }
    
    
    //MARK: - seeAllUser
    
    var seeAllUser: some View {
        Button {} label: {
            VStack(spacing: 15) {
                Text("А можно всех посмотреть?")
                    .boldFont(14)
                    .foregroundColor(.whiteText)
                    .multilineTextAlignment(.center)
                    .frame(width: 100)
                
                Image("seeAll")
            }
            .frame(width: 135, height: 195)
            .background(Color.mintGreen)
            .cornerRadius(15)
        }
    }
    
    
    //MARK: - folders
    
    var folders: some View {
        ContentBlock(title: "Проекты", buttonTitle: "Все") {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: -35) {
                    ForEach(viewModel.friendsData, id: \.self) { folder in
                        VStack(spacing: 13) {
                            //Если индекс четный то во 2, не четный - 1
                            CustomNavigationLink {
                                FolderStrokeCardView(title: "Зарисовки", description: "Дизайн интерьера", folderImages: ["Azizova"], haveProfileButton: true)
                                    .padding(.horizontal, 26)
                            } destination: {
                                UserWorksView(viewModel: UserWorksViewModel())
                            }
                            
                            CustomNavigationLink {
                                FolderStrokeCardView(title: "Загородные дома", description: "Прокуратура", folderImages: ["Dilan"], haveProfileButton: true)
                                    .padding(.horizontal, 26)
                            } destination: {
                                UserWorksView(viewModel: UserWorksViewModel())
                            }
                        }
                        .frame(width: 370)
                    }
                }
            }
        } destination: {
            UserFoldersView(viewModel: UserFoldersViewModel())
        }
    }
    
    
    //MARK: - works
    
    var works: some View {
        ContentBlock(title: "Топ работ") {
            LazyVGrid(columns: viewModel.columns, spacing: 18) {
                ForEach(0...15, id: \.self) { work in
                    ContentCard(name: "work", lastName: "work", description: "work", imageString: "", height: 137, isColor: true)
                }
            }
            .padding(.horizontal, viewModel.screenOffset)
        } destination: {}
        
    }
}


//MARK: - MainView_Previews

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
       DisplayView()
    }
}
