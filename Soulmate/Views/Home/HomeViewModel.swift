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
    
    @Published var notAnAuthorizedUser = true
    @Published var isLoading = false
    
    var columns: [GridItem] = Array(repeating: .init(.flexible(minimum: 90, maximum: 125), spacing: 12, alignment: .top), count: 3)
    
    
    func fetchHomePage() {
        testToken()
        DataFetcherServices.fetchHomePage { home in
            DispatchQueue.main.async {
                guard let suitableUsers = home?.users, let suitableFolders = home?.folders else { return }
                self.suitableUsers = suitableUsers.filter { $0.firstName != nil && $0.lastName != nil }
                self.suitableFolders = suitableFolders
                self.isLoading = false
            }
        }
    }
    
    //для теста
    private func testToken() {
        if let readData = KeychainService.standard.read(account: "access-token", type: AuthToken.self) {
            print("🉐", readData)
            notAnAuthorizedUser = false
        }
    }
}
