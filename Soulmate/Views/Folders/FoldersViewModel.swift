//
//  UserFoldersViewModel.swift
//  Soulmate
//
//  Created by dasha on 10.12.2021.
//

import SwiftUI

final class FoldersViewModel: ObservableObject {
    
    enum ViewStyle {
        case stroke, rectangle
    }
    
    @Published var folders: [FolderModel] = []
    @Published var currentViewStyle: ViewStyle = .stroke
    @Published var projectName: String?
    @Published var isInternetConnected = true
    
    //MARK: - Fetch Data
    
    func fetchData(userProfessionId: Int?) {
        if userProfessionId != nil {
            DataFetcherServices.fetchUserProfessionFolders(id: userProfessionId!) { [weak self] result, foldersArray in
                switch result {case .success:
                    self?.projectName = foldersArray?.profession.name
                    self?.checkAndAssignData(foldersArray?.folders)
                case .failure(let error):
                    if error.errorDescription == NetworkResponseError.internetError.errorDescription {
                        self?.isInternetConnected = false
                    }
                }
            }
        } else {
            DataFetcherServices.fetchAllFolders { [weak self] result, foldersArray in
                switch result {case .success:
                    self?.checkAndAssignData(foldersArray)
                case .failure(let error):
                    if error.errorDescription == NetworkResponseError.internetError.errorDescription {
                        self?.isInternetConnected = false
                    }
                }
            }
        }
    }
    
    private func checkAndAssignData(_ foldersArray: [FolderModel]?) {
        DispatchQueue.main.async {
            guard let folders = foldersArray else { return }
            self.folders = folders
        }
    }
    
    
    func getFolderName() -> String {
        guard let name = projectName else { return "Интересные проекты"}
        return name
    }
    
    
    //MARK: - Action method
    
    func openDetailBottomSheet() {
        print(#function)
    }
    
    func changeFolderView() {
        currentViewStyle = currentViewStyle == .stroke ? .rectangle : .stroke
    }
}

