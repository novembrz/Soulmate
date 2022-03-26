//
//  AboutUserViewModel.swift
//  Soulmate
//
//  Created by dasha on 16.01.2022.
//

import SwiftUI

enum SocialNetwork: String {
    case vk, instagram, facebook, twitter, soundcloud, spotify, youtube, tikTok, telegram, gitHub, twitch, behance, dribble, tumblr, itunes
}

final class AboutUserViewModel: ObservableObject {
    
    @Published var userWorkPlaces: [WorkPlacesModel]?
    @Published var userSocialNetworks: [String]?
    @Published var isAllowWritingMessages = true //будет внутри юзера
    @Published var isLoading = false
    @Published var isInternetConnected = true
    
    //MARK: - Fetch
    
    func fetchUserInfo(_ userId: Int) {
        fetchWorkPlaces(userId)
        fetchSocialNetworks()
    }
    
    private func fetchWorkPlaces(_ userId: Int) {
        isLoading = true
        DataFetcherServices.fetchUserWorkPlaces(id: userId) { [weak self] result, info in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    guard let userWorkPlaces = info else { return }
                    self?.userWorkPlaces = userWorkPlaces
                    self?.isLoading = false
                case .failure(let error):
                    if error.errorDescription == NetworkResponseError.internetError.errorDescription {
                        self?.isInternetConnected = false
                    }
                    self?.isLoading = false
                }
            }
        }
    }
    
    private func fetchSocialNetworks() {

    }
    
    func openSocialNetwork(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
    
    
    
    //MARK: Check
    /*
    private func dateFormatter(dateString: String) { //"2020-10-01T00:00:00.000+0000"
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "yyyy"
        //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" 2020-10-01 00:00:00 +0000
        let date = dateFormatter.date(from: dateString)
        //let date = dateFormatter.date(from: dateString)
        print("🧊 \(date)")
    }
    
    private func dateFormatter2(dateString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let date = dateFormatter.date(from: dateString)
        print("🧊 \(date)")
    }
    */
}

