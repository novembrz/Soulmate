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
                        projects
                        works
                    }
                }
            }
            .padding(.top, 30)
            .padding(.bottom, 70)
        }
        .background(Color.defaultBackground.ignoresSafeArea())
        .fullScreenCover(isPresented: $viewModel.showProfileView) {
            ProfileView(viewModel: ProfileViewModel())
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
        }
    }
    
    
    //MARK: - environment
    
    var environment: some View {
        ContentBlock(title: "Из твоей среды", buttonTitle: "Все") {
            print("environmen all")
        } content: {
            VStack(spacing: viewModel.screenOffset) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 11) {
                        ForEach(viewModel.friendsData, id: \.self) { user in
                            Button {
                                withAnimation {
                                    viewModel.showProfileView = true
                                }
                            } label: {
                                ZStack(alignment: .bottomLeading) {
                                    Image(user)
                                        .resizable()
                                        .frame(width: 135, height: 195)
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(15)
                                    
                                    VStack(alignment: .leading) {
                                        Text("Sasha")
                                            .boldFont(12)
                                            .foregroundColor(.whiteText)
                                        
                                        Text(user)
                                            .boldFont(12)
                                            .foregroundColor(.whiteText)
                                        
                                        Text("Writter")
                                            .regularFont(11)
                                            .foregroundColor(.whiteText)
                                    }
                                    .padding(10)
                                }
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
        }
    }
    
    
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
    
    
    //MARK: projects
    
    var projects: some View {
        ContentBlock(title: "Проекты", buttonTitle: "Все") {
            print()
        } content: {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: -35) {
                    ForEach(viewModel.friendsData, id: \.self) { project in
                        VStack(spacing: 13) {
                            //Если индекс четный то во 2, не четный - 1
                            ProjectCardView(userImage: "Azizova", title: "Зарисовки", description: "Дизайн интерьера", haveProfileButton: true)
                            ProjectCardView(userImage: "Dilan", title: "Загородные дома", description: "Прокуратура", haveProfileButton: true)
                        }
                        .frame(width: 370)
                    }
                }
            }
        }
    }
    
    
    //MARK: works
    
    var works: some View {
        ContentBlock(title: "Топ работ", buttonTitle: "Все") {
            print()
        } content: {
            Text("Топ работ")
        }
    }
}


//MARK: - MainView_Previews

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
       DisplayView()
    }
}
