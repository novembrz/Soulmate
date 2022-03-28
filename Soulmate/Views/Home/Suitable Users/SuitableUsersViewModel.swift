//
//  SuitableUsersViewModel.swift
//  Soulmate
//
//  Created by dasha on 12.01.2022.
//

import SwiftUI


final class SuitableUsersViewModel: ObservableObject {
    
    @Published var suitableUsers: [UserModel]?
    @Published var isInternetConnected = true
    @Published var isLoading = false
    @Published var refreshing = false
    
    var columnsArray: [GridItem] = Array(repeating: .init(.flexible(minimum: 82, maximum: 125), spacing: 12, alignment: .leading), count: 3)
    
    func fetchAllPeople(type: LoadPage = .loading) { //MARK: Временный метод
        if type == .loading { isLoading = true }
        DataFetcherServices.fetchHomePage { [weak self] result, home in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    guard let suitableUsers = home?.users else { return }
                    self?.suitableUsers = suitableUsers
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
}
