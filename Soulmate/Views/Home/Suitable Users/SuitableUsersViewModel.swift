//
//  SuitableUsersViewModel.swift
//  Soulmate
//
//  Created by dasha on 12.01.2022.
//

import SwiftUI


final class SuitableUsersViewModel: ObservableObject {
    
    @Published var suitableUsers: [UserModel]?
    
    var columnsArray: [GridItem] = Array(repeating: .init(.flexible(minimum: 82, maximum: 125), spacing: 12, alignment: .leading), count: 3)
    
    func fetchAllPeople() { //MARK: Временный метод
        DataFetcherServices.fetchHomePage { home in
            DispatchQueue.main.async {
                guard let suitableUsers = home?.users else { return }
                self.suitableUsers = suitableUsers
            }
        }
    }
}
