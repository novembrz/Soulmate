//
//  AboutUserView.swift
//  Soulmate
//
//  Created by dasha on 10.01.2022.
//

import SwiftUI

struct AboutUserView: View {
    
    @State var user: UserModel
    @ObservedObject var viewModel: AboutUserViewModel
    
    var ageString: String { user.age == nil ? "" : "\(user.age ?? 0)" }
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if viewModel.isInternetConnected {
                content
                buttons
            } else {
                InternetConnectionView()
            }
        }
        .padding(.top, Constants.topInset)
        .background(Color.defaultBackground.ignoresSafeArea())
        .onAppear {
            viewModel.fetchUserInfo(user.id)
        }
        .showLoading(isShowing: $viewModel.isLoading)
    }
    
    
    //MARK: - Buttons
    
    var buttons: some View {
        HStack(spacing: 12) {
            Spacer()
            
            if viewModel.isAllowWritingMessages {
                StandartButton(imageName: "send", routing: true)
            }
            
            StandartButton(imageName: "subscribe")
        }
        .padding(.horizontal, Constants.horizontalInset)
    }
    
    
    //MARK: - Content
    
    var content: some View {
        VStack(alignment: .leading, spacing: 38) {
            Group {
                title
                if user.description != nil {
                    BigTextBlock(text: user.description!, textLineLimit: 6)
                }
            }
            .padding(.horizontal, Constants.horizontalInset)
            
            if viewModel.userWorkPlaces != nil {
                workPlaces
            }
            
            Spacer()
        }
        .padding(.bottom, Constants.bottomInset)
    }
    
    
    //MARK: - Title
    
    var title: some View {
        VStack(alignment: .leading, spacing: 23) {
            TitleBlock(viewTitle: "\(user.firstName ?? "")\n\(user.lastName ?? "")", subTitle: "\(user.city ?? ""), \(ageString)")
            
            if viewModel.userSocialNetworks != nil {
                HStack {
                    ForEach(viewModel.userSocialNetworks!, id: \.self) { urlString in
                        Button {
                            viewModel.openSocialNetwork(urlString)
                        } label: {
                            Rectangle()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.mintGreen)
                                .cornerRadius(7)
                        }
                    }
                }
            }
        }
    }
    
    
    //MARK: - Work Places
    
    var workPlaces: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 13) {
                if let workPlaces = viewModel.userWorkPlaces {
                    ForEach(workPlaces, id: \.self) { place in
                        VStack {
                            VStack(spacing: 13) {
                                Image(systemName: "ivfluid.bag")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 55)
                                    .foregroundColor(.blackToWhite)
                                
                                Text(place.name)
                                    .mediumFont(13)
                                    .foregroundColor(.blackText)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(.top, 20)
                            
                            Spacer()
                            
                            Text("fff")
                                .regularFont(12)
                                .foregroundColor(.blackText)
                                .padding(.bottom, 10)
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 115, height: 163)
                        .background(Color.whiteToDark)
                        .cornerRadius(15)
                    }
                }
            }
            .padding(.horizontal, Constants.horizontalInset)
        }
        .elementShadow()
    }
}


//MARK: - Previews

struct AboutUserView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUserView(user: MockService.mockUser, viewModel: AboutUserViewModel())
            .preferredColorScheme(.dark)
    }
}
