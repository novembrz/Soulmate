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
        ZStack(alignment: .top) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: -120) {
                    profile
                    GridView(viewModel: viewModel)
                }
                .padding(.bottom, 70)
            }
            .background(Color.defaultBackground.ignoresSafeArea())
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
            
            TitleBlock(viewTitle: "\(viewModel.user?.firstName ?? "")\n\(viewModel.user?.lastName ?? "")", titleColor: .whiteText) {
                actionButtons
            }
            
            VStack(alignment: .leading, spacing: 40) {
                profileBaseInfo
                professions
            }
        }
        .padding(.horizontal, viewModel.screenOffset)
    }
    
    
    //MARK: - Profile Main Info
    
    var profileMainInfo: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("\(viewModel.user?.firstName ?? "")\n\(viewModel.user?.lastName ?? "")")
                .boldFont(24)
                .foregroundColor(.whiteText)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 0)
            
            Text("\(viewModel.user?.city ?? ""), \(viewModel.user?.age ?? 0)")
                .mediumFont(18)
                .foregroundColor(.whiteText)
                .shadow(color: .black.opacity(0.5), radius: 8, x: 0, y: 0)
        }
    }
    
    
    //MARK: - Action Buttons
    
    var actionButtons: some View {
        HStack(alignment: .top) {
//            BackButton()
//
//            Spacer()
            
            VStack(alignment: .trailing, spacing: 12) {
                HStack(spacing: 12) {
                    if viewModel.isAllowWritingMessages {
                        StandartButton(imageName: "send", action: viewModel.routeToMessage)
                    }
                    StandartButton(imageName: "subscribe", action: viewModel.subscribeUser)
                }
                StandartButton(imageName: "dote", action: viewModel.routeToUserDescription)
            }
        }
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
                        .shadow(color: .blackText.opacity(0.3), radius: 2, x: 0, y: 0)
                }
            }
        }
    }
}


//MARK: - Previews

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        //DisplayView()
        ProfileView(viewModel: ProfileViewModel())
    }
}
