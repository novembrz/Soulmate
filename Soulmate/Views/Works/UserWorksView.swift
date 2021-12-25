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
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 35) {
                title
                description
                works
            }
            .padding(.bottom, 70)
            .padding(.horizontal, 26)
        }
        .background(Color.defaultBackground.ignoresSafeArea())
    }
    
    
    //MARK: - Title
    
    var title: some View {
        VStack(alignment: .leading, spacing: 11) {
            
            TitleBlock(viewTitle: viewModel.projectName) {
                Button {} label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 43, height: 43)
                            .foregroundColor(.whiteToDark)
                        
                        Image("more")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
            }
            
            HStack(spacing: 3) {
                Image(viewModel.author)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFill()
                    .cornerRadius(10)
                
                if let coauthors = viewModel.coauthors {
                    ForEach(coauthors, id: \.self) { coauthor in
                        Image(coauthor)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .scaledToFill()
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
    
    
    //MARK: - Descripton
    
    var description: some View {
        VStack(alignment: .trailing, spacing: 12) {
            Text(viewModel.projectDescription)
                .mediumFont(14)
                .foregroundColor(.blackText)
                .lineLimit(viewModel.readMore ? nil : 3)
                .lineSpacing(7)
            
            if !viewModel.readMore {
                Button {
                    viewModel.readMore = true
                } label: {
                    Text("читать дальше...")
                        .boldFont(16)
                        .foregroundColor(.mintGreen)
                }
            }
        }
    }
    
    
    //MARK: - Works
    
    var works: some View {
        VStack {
            if let works = viewModel.works {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: viewModel.columns) {
                        ForEach(works, id: \.self) { work in
                            VStack(alignment: .leading, spacing: 2) {
                                Image(work)
                                    .resizable()
                                    //.aspectRatio(contentMode: .fill)
                                    .frame(height: 210)
                                    .aspectRatio(contentMode: .fit)
                                    //.frame(width: 163)
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
}

struct WorksView_Previews: PreviewProvider {
    static var previews: some View {
        UserWorksView(viewModel: UserWorksViewModel())
    }
}
