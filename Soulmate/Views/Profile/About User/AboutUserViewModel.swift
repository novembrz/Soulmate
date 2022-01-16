//
//  AboutUserViewModel.swift
//  Soulmate
//
//  Created by dasha on 16.01.2022.
//

import Foundation


final class AboutUserViewModel: ObservableObject {
    
    @Published var userWorkPlaces: [WorkPlacesModel]?
    @Published var isAllowWritingMessages = true //будет внутри юзера
    
    //MARK: - Fetch
    
    func fetchWorkPlaces(_ userId: Int) {
        DataFetcherServices.fetchUserWorkPlaces(id: userId) { result in
            DispatchQueue.main.async {
                guard let userWorkPlaces = result else { return }
                self.userWorkPlaces = userWorkPlaces
                self.dateFormatter2(dateString: userWorkPlaces[0].startDate)
            }
        }
    }
    
    
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
    
}

