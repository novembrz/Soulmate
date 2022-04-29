//
//  SuitableUsersViewModel.swift
//  Soulmate
//
//  Created by dasha on 12.01.2022.
//

import SwiftUI


final class SuitableUsersViewModel: ObservableObject {
    
    private let store = NetworkServiceStore()
    
    @Published var suitableUsers: [UserModel]?
    @Published var isInternetConnected = true
    @Published var isLoading = false
    @Published var refreshing = false
    
    var columnsArray: [GridItem] = Array(repeating: .init(.flexible(minimum: 82, maximum: 125), spacing: 12, alignment: .leading), count: 3)
    
    func fetchAllPeople(type: LoadPage = .loading) {
        Task {
            try? await fetchData(type: type)
        }
    }
    
    @MainActor
    private func fetchData(type: LoadPage) async throws {
        if type == .loading { isLoading = true }
        defer { type == .loading ? (isLoading = false) : (refreshing = false) }
        
        if let home = try await store.fetchData(urlString: ServiceUrl.homePageURL, model: HomeModel.self) {
            if let suitableUsers = home.users {
                self.suitableUsers = suitableUsers.filter { $0.firstName != nil && $0.lastName != nil }
            }
        } else {
            isInternetConnected = false
        }
    }
}
