//
//  ContentView.swift
//  Soulmate
//
//  Created by dasha on 20.11.2021.
//

import SwiftUI


//MARK: - Profile View

struct ProfileView: View {
    
    @State var userId: Int
    @State var authorizedUserProfile: Bool = false
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            RefreshableScrollView(refreshing: $viewModel.refreshing) {
                VStack(spacing: -70) {
                    if viewModel.isInternetConnected {
                        profile
                        GridView(viewModel: viewModel)
                    } else {
                        InternetConnectionView()
                    }
                }
                .padding(.top, Constants.topInset)
                .padding(.bottom, 140)
            }
            .background(Color.defaultBackground.ignoresSafeArea())
            
            if authorizedUserProfile {
                chartButton
            } else {
                actionButtons
            }
        }
        .onAppear { viewModel.fetchUser(userId) }
        .onChange(of: viewModel.refreshing) { newValue in
            viewModel.fetchUser(userId, type: .refreshing)
        }
    }
    
    
    //MARK: - Profile
    
    var profile: some View {
        GeometryReader { reader in
            AsyncImage(url: URL(string: viewModel.user?.avatars?
                                    .filter { $0.main ?? false }
                                    .first?.link ?? "")) { image in
                image.resizable()
            } placeholder: {
                LottieView(filename: "loadingLottie", isLooping: true)
                    .frame(width: 200, height: 200)
            }
            .aspectRatio(contentMode: .fill)
            .offset(y: -reader.frame(in: .global).minY)
            .frame(width: viewModel.width,
                   height: reader.frame(in: .global).minY + viewModel.maxHeigth)
            
            Image("blur")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(y: viewModel.maxHeigth / 1.9)
            
            profileInfo
        }
        .frame(height: viewModel.maxHeigth )
    }
    
    
    //MARK: - Profile Info
    
    var profileInfo: some View {
        VStack(alignment: .leading, spacing: authorizedUserProfile ? 200 : 130) {
            TitleBlock(viewTitle: viewModel.title,
                       subTitle: viewModel.description,
                       titleColor: .whiteText,
                       topPadding: authorizedUserProfile ? 0 : 77)
            
            VStack(alignment: .leading, spacing: 40) {
                profileBaseInfo
                professions
            }
        }
        .padding(.horizontal, Constants.horizontalInset)
    }
    
    
    //MARK: - Profile Main Info
    
    var profileMainInfo: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("\(viewModel.user?.firstName ?? "")\n\(viewModel.user?.lastName ?? "")")
                .boldFont(24)
                .foregroundColor(.whiteText)
                .textShadow(radius: 10)
            
            Text("\(viewModel.user?.city ?? ""), \(viewModel.user?.age ?? 0)")
                .mediumFont(18)
                .foregroundColor(.whiteText)
                .textShadow(opacity: 0.5, radius: 8)
        }
    }
    
    
    //MARK: - Chart Buttons
    
    var chartButton: some View {
        CustomNavigationLink {
            BigStandartButton(imageName: "chart")
                .padding(.horizontal, Constants.horizontalInset)
                .padding(.top, Constants.topInset)
        } destination: {
            AboutUserView(user: viewModel.user ?? MockService.mockUser, viewModel: AboutUserViewModel())
                .frame(maxWidth: .infinity)
        }
    }
    
    
    //MARK: - Action Buttons
    
    var actionButtons: some View {
        HStack(alignment: .top) {
            VStack(alignment: .trailing, spacing: 12) {
                HStack(spacing: 12) {
                    if viewModel.isAllowWritingMessages {
                        StandartButton(imageName: "send", routing: true)
                    }
                    StandartButton(imageName: "subscribe")
                }
                
                CustomNavigationLink {
                    StandartButton(imageName: "dote", routing: true)
                } destination: {
                    AboutUserView(user: viewModel.user ?? MockService.mockUser, viewModel: AboutUserViewModel())
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal, Constants.horizontalInset)
        .padding(.top, Constants.topInset)
        
    }
    
    
    //MARK: - Profile Base Info
    
    var profileBaseInfo: some View {
        VStack(alignment: .leading, spacing: 7) {
            ProfileBaseInfoView(icon: "like", number: viewModel.user?.totalLikes ?? 0)
            ProfileBaseInfoView(icon: "work", number: viewModel.user?.totalWorks ?? 0)
            ProfileBaseInfoView(icon: "people", number: viewModel.user?.totalSubscribers ?? 0)
        }
    }
    
    
    //MARK: - Professions
    
    var professions: some View {
        HStack(alignment: .bottom) {
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                ForEach(viewModel.personProfessions, id: \.self) { profession in
                    Text(profession.name.lowercased())
                        .mediumFont(18)
                        .foregroundColor(.whiteText)
                        .multilineTextAlignment(.trailing)
                        .textShadow()
                }
            }
        }
    }
}


//MARK: - Previews

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CustomNavigationView {
                ProfileView(userId: 5, viewModel: ProfileViewModel())
            }
        }
    }
}

