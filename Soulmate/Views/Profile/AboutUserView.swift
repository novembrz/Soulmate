//
//  AboutUserView.swift
//  Soulmate
//
//  Created by dasha on 10.01.2022.
//

import SwiftUI

struct AboutUserView: View {
    
    @State var isAllowWritingMessages = true //будет внутри юзера
    @State var user: UserModel
    
    var ageString: String { user.age == nil ? "" : "\(user.age ?? 0)" }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            content
            buttons
        }
        .background(Color.defaultBackground.ignoresSafeArea())
    }
    
    
    //MARK: - Buttons
    
    var buttons: some View {
        HStack(spacing: 12) {
            Spacer()
            
            if isAllowWritingMessages {
                StandartButton(imageName: "send")
            }
            
            StandartButton(imageName: "subscribe")
        }
        .padding(.horizontal, 26)
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
            .padding(.horizontal, 26)
            
            //MARK: if workPlaces != nil
            workPlaces
            
            Spacer()
        }
        .padding(.bottom, 70)
    }
    
    
    //MARK: - Title
    
    var title: some View {
        VStack(alignment: .leading, spacing: 23) {
            TitleBlock(viewTitle: "\(user.firstName)\n\(user.lastName)", subTitle: "\(user.city ?? ""), \(ageString)")
            
            //MARK: if social != nil
            HStack {
                ForEach(0...3, id: \.self) { item in
                    Rectangle()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.mintGreen)
                        .cornerRadius(7)
                }
            }
        }
    }
    
    
    //MARK: - Work Places
    
    var workPlaces: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 13) {
                ForEach(0...3, id: \.self) { item in
                    VStack {
                        VStack(spacing: 11) {
                            Image(systemName: "ivfluid.bag")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 55)
                                .foregroundColor(.blackToWhite)
                            
                            Text("sdsdfadf")
                                .mediumFont(13)
                                .foregroundColor(.blackText)
                        }
                        .padding(.top, 20)
                        
                        Spacer()
                        
                        Text("ssdv")
                            .regularFont(12)
                            .foregroundColor(.blackText)
                            .padding(.bottom, 10)
                        
                    }
                    .frame(width: 115, height: 163)
                    .background(Color.whiteToDark)
                    .cornerRadius(15)
                }
            }
            .padding(.horizontal, 26)
        }
        .shadow(color: .elementShadow.opacity(0.3), radius: 30, x: 4, y: 4)
    }
}


//MARK: - Previews

struct AboutUserView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUserView(user: MockService.mockUser)
    }
}
