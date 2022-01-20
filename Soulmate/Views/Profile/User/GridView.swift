//
//  GridView.swift
//  Soulmate
//
//  Created by dasha on 27.11.2021.
//

import SwiftUI


//MARK: - Grid View

struct GridView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        HStack(alignment: .top, spacing: viewModel.cardsOffset) {
            ForEach(viewModel.columns) { column in
                LazyVStack(alignment: .leading, spacing: viewModel.cardsOffset) {
                    if let user = viewModel.user {
                        CardView(column: column, color: user.color ?? viewModel.defaultHex, user: viewModel.user)
                    }
                }
                .offset(y: viewModel.columnIndex(of: column) == 0 ? 60 : 0)
            }
        }
        .padding(.horizontal, Constants.horizontalInset)
    }
}


//MARK: - Card View

struct CardView: View {
    
    var column: ColumnModel
    var color: String
    var user: UserModel?
    
    var body: some View {
        
        ForEach(column.gridItems) { grid in
            CustomNavigationLink {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(grid.main ? Color(hex: color) : .whiteToDark)
                        .frame(height: 200)
                        .cornerRadius(22)
                    
                    VStack(alignment: .leading) {
                        Text(grid.name)
                            .boldFont(16)
                            .foregroundColor(grid.main ? .whiteText : .blackText)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                        
                        HStack(spacing: 6) {
                            Text("\(grid.worksCount ?? 0)")
                                .boldFont(16)
                                .foregroundColor(grid.main ? .whiteText : .blackText)
                                 
                            Text("работа".pluralLocalized(number: grid.worksCount ?? 0))
                                .regularFont(16)
                                .foregroundColor(grid.main ? .whiteText : .blackText)
                        }
                    }
                    .padding(.vertical, 25)
                    .padding(.horizontal, 15)
                }
            } destination: {
                FoldersView(viewModel: FoldersViewModel(), userProfessionId: grid.userProfessionId)
            }
        }
    }
}


//MARK: - Card View Previews

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationView {
            ProfileView(userId: 2, viewModel: ProfileViewModel())
        }
    }
}
