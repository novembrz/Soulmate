//
//  FiltersView.swift
//  Soulmate
//
//  Created by dasha on 29.03.2022.
//

import SwiftUI

struct FiltersView: View {
    //CheckboxGroupView
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 50) {
            if viewModel.homeViewState == .errorInternetConnection {
                content
                categories
            } else {
                InternetConnectionView()
            }
        }
        .padding(.horizontal, Constants.horizontalInset)
        .padding(.top, Constants.topInset)
    }
    
    
    var content: some View {
        VStack(spacing: 25) {
            TitleBlock(viewTitle: "Фильтр")
            

        }
    }
    
    var categories: some View {
        VStack {
            TitleBlock(viewTitle: "Категории")
            Text("")
        }
    }
}


//MARK: - Previews

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(viewModel: HomeViewModel())
    }
}
