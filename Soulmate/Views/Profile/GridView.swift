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
                        CardView(column: column, color: user.color)
                    }
                }
                .offset(y: viewModel.columnIndex(of: column) == 0 ? 60 : 0)
            }
        }
        .padding(.horizontal, viewModel.screenOffset)
        
    }
}


//MARK: - Card View

struct CardView: View {
    
    var column: ColumnModel
    var color: String
    
    var body: some View {
        
        ForEach(column.gridItems) { grid in
            Button {} label: {
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
                            Text("\(5)")
                                .boldFont(16)
                                .foregroundColor(grid.main ? .whiteText : .blackText)
                                 
                            Text("работа".pluralLocalized(number: 5))
                                .regularFont(16)
                                .foregroundColor(grid.main ? .whiteText : .blackText)
                        }
                    }
                    .padding(.vertical, 25)
                    .padding(.horizontal, 15)
                }
            }
        }
    }
}


//MARK: - Card View Previews

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel())
    }
}
