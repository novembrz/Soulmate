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

final class HomeViewModel: ObservableObject {

    @Published var professionalSpheres = MockService.professionalSpheres
    
    @Published var suitableUsers: [UserModel] = []
    @Published var suitableFolders: [FolderModel] = []
    @Published var suitableCards: [CardModel] = []
    
    @Published var notAnAuthorizedUser = false //Это не авториз пользовать
    
    @Published var isLoading = false
    @Published var refreshing = false
    @Published var isInternetConnected = true
    
    var cardColumns: [GridItem] = Array(repeating: .init(.flexible(minimum: 90, maximum: 125), spacing: 12, alignment: .top), count: 3)
    var folderColumns: [GridItem] = Array(repeating: .init(.fixed(65), spacing: 13, alignment: .topLeading), count: 2)
    
    
    func fetchHomePage(type: LoadPage = .loading) {
        if type == .loading { isLoading = true }
        DataFetcherServices.fetchHomePage { [weak self] result, home in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    guard let suitableUsers = home?.users,
                          let suitableCards = home?.cards,
                          let suitableFolders = home?.folders
                    else { return }
                    
                    self?.suitableUsers = suitableUsers.filter { $0.firstName != nil && $0.lastName != nil }
                    self?.suitableFolders = suitableFolders
                    self?.suitableCards = suitableCards
                case .failure(let error):
                    if error.errorDescription == NetworkResponseError.internetError.errorDescription {
                        self?.isInternetConnected = false
                    }
                }
                self?.stopLoading(type: type)
            }
        }
    }
    
    private func stopLoading(type: LoadPage) {
        type == .loading ? (isLoading = false) : (refreshing = false)
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
