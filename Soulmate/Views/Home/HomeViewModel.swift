//
//  HomeViewModel.swift
//  Soulmate
//
//  Created by dasha on 30.11.2021.
//

import SwiftUI


final class HomeViewModel: ObservableObject {

    @Published var professionalSpheres = MockService.professionalSpheres
    
    @Published var suitableUsers: [UserModel] = []
    @Published var suitableFolders: [FolderModel] = []
    
    @Published var notAnAuthorizedUser = false //Это не авториз пользовать
    @Published var isLoading = false
    
    var columns: [GridItem] = Array(repeating: .init(.flexible(minimum: 90, maximum: 125), spacing: 12, alignment: .top), count: 3)
    
    
    func fetchHomePage() {
        isLoading = true
        DataFetcherServices.fetchHomePage { [weak self] home in
            guard let suitableUsers = home?.users, let suitableFolders = home?.folders else { return }
            self?.suitableUsers = suitableUsers.filter { $0.firstName != nil && $0.lastName != nil }
            self?.suitableFolders = suitableFolders
            self?.isLoading = false
        }
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
