//
//  FiltersView.swift
//  Soulmate
//
//  Created by dasha on 29.03.2022.
//

import SwiftUI

struct FiltersView: View {
    
    enum FilterViewType {
        case sphere, professions
    }
    
    @ObservedObject var viewModel: HomeViewModel
    @State var deleteAll = false
    @State var viewType: FilterViewType = .sphere
    @State var selectedFilters: [String] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 50) {
            if viewModel.homeViewState == .errorInternetConnection {
                InternetConnectionView()
            } else {
                ZStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        filters
                        categories
                    }
                    
                    VStack {
                        deleteButton
                        Spacer()
                        applyButton
                    }
                }
            }
        }
        .padding(.horizontal, Constants.horizontalInset)
        .padding(.top, Constants.topInset)
    }
    
    
    var filters: some View {
        VStack(alignment: .leading, spacing: 25) {
            TitleBlock(viewTitle: "Фильтры")
            
            CheckboxGroupView(
                checkbox: [
                    CheckboxModel(title: "Люди", filterName: SearchCategory.user.rawValue),
                    CheckboxModel(title: "Работы", filterName: SearchCategory.card.rawValue),
                    CheckboxModel(title: "Проекты", filterName: SearchCategory.folder.rawValue)
                ],
                deleteAll: $deleteAll) { selectedFilters in
                    self.selectedFilters = selectedFilters
                }
        }
    }
    
    var categories: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                TitleBlock(viewTitle: "Категории", topPadding: 50)
                picker
                Spacer()
            }
            .animation(.spring(), value: viewType)
            
            Spacer()
        }
    }
    
    var picker: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 32) {
                Button {
                    viewType = .sphere
                } label: {
                    Text("Сферы")
                        .foregroundColor(.blackText)
                        .mediumFont(16)
                }
                
                Button {
                    viewType = .professions
                } label: {
                    Text("Профессии")
                        .foregroundColor(.blackText)
                        .mediumFont(16)
                }
            }
            
            Capsule()
                .frame(width: viewType == .sphere ? 60 : 100, height: 1)
                .offset(x: viewType == .sphere ? 0 : 89)
                .foregroundColor(.blackText)
        }
    }
    
    
    //MARK: - Buttons
    
    var applyButton: some View {
        Button {
            
        } label: {
            LongButton(title: "Применить фильтры")
        }
    }
    
    var deleteButton: some View {
        HStack {
            Spacer()
            Button {
                viewModel.deleteAllFilters = true
            } label: {
                Text("Очистить фильтры")
                    .boldFont(16)
                    .foregroundColor(.mintGreen)
            }
            .opacity(selectedFilters == [] ? 0 : 1)
            .disabled(selectedFilters == [])
        }
    }
}


//MARK: - Previews

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(viewModel: HomeViewModel())
    }
}
