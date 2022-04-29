//
//  HomeViewModel.swift
//  Soulmate
//
//  Created by dasha on 30.11.2021.
//

import SwiftUI

enum LoadPage {
    case loading, refreshing
}

enum HomeViewState {
    case home, searchSuccess, noSearchData, errorInternetConnection, error
}

final class HomeViewModel: ObservableObject {
    
    private let store = NetworkServiceStore()
    
    @Published var homeViewState: HomeViewState = .home

    @Published var professionalSpheres = MockService.professionalSpheres
    
    @Published var suitableUsers: [UserModel] = []
    @Published var suitableFolders: [FolderModel] = []
    @Published var suitableCards: [CardModel] = []
    
    @Published var isLoading = false
    @Published var refreshing = false
    
    @Published var searchText = ""
    @Published var isSearching = false
    
    @State var deleteAllFilters = false
    @State var selectedFilters: [String] = []
    
    var searchCategories: [String] = [SearchCategory.user.rawValue, SearchCategory.card.rawValue,SearchCategory.folder.rawValue, SearchCategory.profession.rawValue]
    
    var cardColumns: [GridItem] = Array(repeating: .init(.flexible(minimum: 90, maximum: 125), spacing: 12, alignment: .top), count: 3)
    var folderColumns: [GridItem] = Array(repeating: .init(.fixed(65), spacing: 13, alignment: .topLeading), count: 2)
    
    func randomSearchString() -> String {
        let words = ["Найди своё окружение", "Найди своё вдохновение", "Найди интересные проекты", "Найди своё комьюнити", "Найди лучшие работы"]
        return words.randomElement()!
    }
    
    
    func fetchHomePage(type: LoadPage = .loading, newData: String? = "") {
        Task {
            if searchText == "" {
                try? await fetchRelevantData(type: type, urlString: ServiceUrl.homePageURL)
            } else {
                if newData == searchText, searchText != "" {
                    try? await fetchSearchData(type: type, urlString: ServiceUrl.search)
                }
            }
        }
    }
    
    @MainActor
    private func fetchRelevantData(type: LoadPage, urlString: String) async throws {
        if type == .loading { isLoading = true }
        defer { type == .loading ? (isLoading = false) : (refreshing = false) }
        
        homeViewState = .home
        
        do {
            if let home = try await store.fetchData(urlString: urlString, model: HomeModel.self) {
                assignValues(home: home)
            }
        } catch {
            errorHandling(error, state: .error)
        }
    }
    
    @MainActor
    private func fetchSearchData(type: LoadPage, urlString: String) async throws {
        if type == .loading { isLoading = true }
        defer { type == .loading ? (isLoading = false) : (refreshing = false) }
        
        homeViewState = .searchSuccess
        
        do {
            if let home = try await store.postData(param: ["sorting": ["pageNumber": 0,
                                                                       "pageSize": 10,
                                                                       "sortDirection": "ASC",
                                                                       "sortBy": "id"],
                                                           "text": searchText,
                                                           "searchTypes": searchCategories],
                                                   urlString: urlString,
                                                   model: HomeModel.self) {
                assignValues(home: home)
            }
        } catch {
            errorHandling(error, state: .noSearchData)
        }
    }
    
    private func assignValues(home: HomeModel) {
        if let users = home.users {
            suitableUsers = users.filter { $0.firstName != nil && $0.lastName != nil }
        }
        
        if let folders = home.folders {
            self.suitableFolders = folders
        }
        
        if let cards = home.cards {
            self.suitableCards = cards
        }
    }
    
    private func errorHandling(_ error: Error, state: HomeViewState) {
        if error as! NetworkResponseError == NetworkResponseError.internetError {
            homeViewState = .errorInternetConnection
        } else {
            homeViewState = state
        }
    }
}
