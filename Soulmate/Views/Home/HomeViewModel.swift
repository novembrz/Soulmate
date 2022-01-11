//
//  HomeViewModel.swift
//  Soulmate
//
//  Created by dasha on 30.11.2021.
//

import SwiftUI


final class HomeViewModel: ObservableObject {

    @Published var professionalSpheres = MockService.professionalSpheres
    @Published var friendsData = MockService.friendsData
    @Published var suitableUsers: [UserModel] = []
    
    var columns: [GridItem] = Array(repeating: .init(.flexible(minimum: 90, maximum: 125), spacing: 12, alignment: .top), count: 3)
    
    func fetchHomePage() {
        DataFetcherServices.fetchHomePage { home in
            DispatchQueue.main.async {
                guard let suitableUsers = home?.users else { return }
                self.suitableUsers = suitableUsers
//                let b = home?.users[0].userProfessions?
//                    .filter{$0.name != nil}
//                    .map{$0.id}
//                    .map{print($0)}
                    
//                let a = (home?.users[0].avatars?.filter { $0.main }.map{ $0.link }) // [option(avatar(msin, link))] // [op[t link]
                
                print("🏉")
            }
        }
    }
}
