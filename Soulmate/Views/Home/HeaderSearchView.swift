//
//  HomeContentView.swift
//  Soulmate
//
//  Created by dasha on 21.04.2022.
//

import SwiftUI

struct HeaderSearchView<Content: View>: View {
    @ObservedObject var viewModel: HomeViewModel
    private let content: Content
    
    init(viewModel: HomeViewModel, @ViewBuilder content: () -> Content) {
        self.viewModel = viewModel
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            title
            
            VStack(alignment: .leading, spacing: 25) {
                searchBlock
                content
            }
        }
        .padding(.top, 30)
        .padding(.bottom, Constants.bottomInset)
    }


    //MARK: - search block

    var title: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Поиск")
                .boldFont(25)
                .foregroundColor(.blackText)

            Text(viewModel.homeViewState == .searchSuccess ? "По твоему запросу".lowercased() : "По всем интересам".lowercased())
                .regularFont(18)
                .foregroundColor(.blackText)
        }
        .padding(.horizontal, Constants.horizontalInset)
    }


    //MARK: - search block

    var searchBlock: some View {
        HStack(spacing: 11) {
            SearchView(viewModel: viewModel)
            filterButton
        }
        .padding(.horizontal, Constants.horizontalInset)
    }


    //MARK: - filter Button

    var filterButton: some View {
        VStack {
            CustomNavigationLink {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.mintGreen)
                        .frame(width: 37, height: 47)

                    Image("filter")
                        .resizable()
                        .frame(width: 14, height: 18)
                        .foregroundColor(.whiteText)
                }
            } destination: {
                FiltersView(viewModel: viewModel)
            }
        }
    }
}

