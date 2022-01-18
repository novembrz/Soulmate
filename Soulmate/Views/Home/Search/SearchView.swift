//
//  SearchView.swift
//  Soulmate
//
//  Created by dasha on 30.11.2021.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        HStack {
            HStack {
                TextField(viewModel.randomString(), text: $viewModel.searchText)
                    .frame(height: 47)
                    .padding(.leading, 40)
                    .disableAutocorrection(true)
                    .mediumFont(12)
                    .foregroundColor(.blackText)
                    .background(Color.whiteToDark)
                    .accentColor(.mintGreen)
                    .cornerRadius(15)
            }
            .padding(.vertical, 30)
            .onTapGesture {
                viewModel.isSearching = true
            }
            .overlay(
                xmarkButtonAndIcon
            )
            .transition(.move(edge: .trailing))
            .animation(.easeOut, value: 0.5)
        }
    }
    
    
    //MARK: - xmark Button
    
    var xmarkButtonAndIcon: some View {
        HStack {
            Image("search")
            Spacer()
            
            if viewModel.searchText != "" {
                Button {
                    viewModel.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle")
                        .padding(.vertical)
                }
            }
        }
        .padding(.horizontal, 12)
        .foregroundColor(.darkForElements)
    }
}


//MARK: - SearchView_Previews

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
