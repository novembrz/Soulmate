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
    case home, searchSuccess, noSearchData, errorInternetConnection
}

final class HomeViewModel: ObservableObject {
    
    @Published var homeViewState: HomeViewState = .home

    @Published var professionalSpheres = MockService.professionalSpheres
    
    @Published var suitableUsers: [UserModel] = []
    @Published var suitableFolders: [FolderModel] = []
    @Published var suitableCards: [CardModel] = []
    
    @Published var isLoading = false
    @Published var refreshing = false
    
    @Published var searchText = ""
    @Published var isSearching = false
    
    var cardColumns: [GridItem] = Array(repeating: .init(.flexible(minimum: 90, maximum: 125), spacing: 12, alignment: .top), count: 3)
    var folderColumns: [GridItem] = Array(repeating: .init(.fixed(65), spacing: 13, alignment: .topLeading), count: 2)
    
    func randomSearchString() -> String {
        let words = ["Найди своё окружение", "Найди своё вдохновение", "Найди интересные проекты", "Найди своё комьюнити", "Найди лучшие работы"]
        return words.randomElement()!
    }
    
    
    func fetchHomePage(type: LoadPage = .loading, newData: String? = "") {
        if type == .loading { isLoading = true }
        
        if searchText == "" {
            fetchRelevantData(type: type)
        } else {
            if newData == searchText, searchText != "" {
                fetchSearchingData(type: type)
            }
        }
    }
    
    private func fetchRelevantData(type: LoadPage) {
        homeViewState = .home
        DataFetcherServices.fetchHomePage { [weak self] result, home in
            self?.fetchData(result: result, home: home, type: type)
        }
    }
    
    private func fetchSearchingData(type: LoadPage) {
        homeViewState = .searchSuccess
        DataFetcherServices.fetchSearchingData(searchingText: searchText) { [weak self] result, home in
            self?.fetchData(result: result, home: home, type: type)
        }
    }
    
    private func fetchData(result: Result, home: HomeModel?, type: LoadPage = .loading) {
        DispatchQueue.main.async {
            switch result {
            case .success:
                guard let home = home else { return self.noDataError(type: type) }
                self.assignValues(home: home)
            case .failure(let error):
                if error.errorDescription == NetworkResponseError.internetError.errorDescription {
                    self.homeViewState = .errorInternetConnection
                }
            }
            self.stopLoading(type: type)
        }
    }
    
    private func assignValues(home: HomeModel) {
        if let suitableUsers = home.users {
            self.suitableUsers = suitableUsers.filter { $0.firstName != nil && $0.lastName != nil }
        }
        
        if let suitableFolders = home.folders {
            self.suitableFolders = suitableFolders
        }
        
        if let suitableCards = home.cards {
            self.suitableCards = suitableCards
        }
    }
    
    private func stopLoading(type: LoadPage) {
        type == .loading ? (isLoading = false) : (refreshing = false)
    }
    
    private func noDataError(type: LoadPage) {
        stopLoading(type: type)
        homeViewState = .noSearchData
    }
    
    
    
    //MARK: - Zhopka
    
    //    @Published var didApper: Bool = false
    //    @Published var apperCount = 0
    //
    //    func onLoad() {
    //        if !didApper {
    //            apperCount += 1
    //        }
    //        didApper = true
    //
    //        if didApper {
    //            //checkToken()
    //        }
    //    }
}
