//
//  ContentView.swift
//  Soulmate
//
//  Created by dasha on 20.11.2021.
//

import SwiftUI


//MARK: - Profile View

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: -120) {
                    profile
                    GridView(viewModel: viewModel)
                }
                .padding(.bottom, Constants.bottomInset)
            }
            .background(Color.defaultBackground.ignoresSafeArea())
            
            actionButtons
        }
        .onAppear { viewModel.fetchUser() }
    }
    
    
    //MARK: - Profile
    
    var profile: some View {
        GeometryReader { reader in
            Image(viewModel.user?.username ?? "")
                .resizable()
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
        VStack(alignment: .leading, spacing: 110) {
            TitleBlock(viewTitle: viewModel.title,
                          subTitle: viewModel.description,
                          titleColor: .whiteText)
            
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
    
    
    //MARK: - Action Buttons
    
    var actionButtons: some View {
        HStack(alignment: .top) {
            VStack(alignment: .trailing, spacing: 12) {
                HStack(spacing: 12) {
                    if viewModel.isAllowWritingMessages {
                        StandartButton(imageName: "send")
                    }
                    StandartButton(imageName: "subscribe")
                }
                
                CustomNavigationLink { //MARK: aaaaaaa
                    StandartButton(imageName: "dote")
                } destination: {
                    AboutUserView(user: viewModel.user ?? MockService.mockUser)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal, Constants.horizontalInset)
    }
    
    
    //MARK: - Profile Base Info
    
    var profileBaseInfo: some View {
        VStack(alignment: .leading, spacing: 7) {
            ProfileBaseInfoView(icon: "like", number: 1005)
            ProfileBaseInfoView(icon: "work", number: 436)
            ProfileBaseInfoView(icon: "people", number: 11537)
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
        ProfileView(viewModel: ProfileViewModel())
    }
}
