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
    @Published var refreshing = false
    @Published var isInternetConnected = true
    
    //MARK: - Fetch
    
    func fetchUserInfo(_ userId: Int, type: LoadPage = .loading) {
        if type == .loading { isLoading = true }
        fetchWorkPlaces(userId, type: type)
        fetchSocialNetworks(type: type)
    }
    
    private func fetchWorkPlaces(_ userId: Int, type: LoadPage) {
        DataFetcherServices.fetchUserWorkPlaces(id: userId) { [weak self] result, info in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    guard let userWorkPlaces = info else { return }
                    self?.userWorkPlaces = userWorkPlaces
                case .failure(let error):
                    if error.errorDescription == NetworkResponseError.internetError.errorDescription {
                        self?.isInternetConnected = false
                    }
                }
                self?.stopLoading(type: type)
            }
        }
    }
    
    private func fetchSocialNetworks(type: LoadPage) {

    }
    
    private func stopLoading(type: LoadPage) {
        type == .loading ? (isLoading = false) : (refreshing = false)
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

