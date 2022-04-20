//
//  FiltersView.swift
//  Soulmate
//
//  Created by dasha on 29.03.2022.
//

import SwiftUI

struct FiltersView: View {
    //CheckboxGroupView
    
    @ObservedObject var viewModel: FiltersViewModel
    
    var body: some View {
        VStack(spacing: 50) {
            if viewModel.isInternetConnected {
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

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(viewModel: FiltersViewModel())
    }
}
