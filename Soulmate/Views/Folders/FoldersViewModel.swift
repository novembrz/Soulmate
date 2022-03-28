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
    @Published var refreshing = false
    
    //MARK: - Fetch Data
    
    func fetchData(userProfessionId: Int?, type: LoadPage = .loading) {
        if userProfessionId != nil {
            fetchUserProfessionFolders(userProfessionId, type: type)
        } else {
            fetchAllFolders(type: type)
        }
    }
    
    private func fetchUserProfessionFolders(_ userProfessionId: Int?, type: LoadPage) {
        DataFetcherServices.fetchUserProfessionFolders(id: userProfessionId!) { [weak self] result, foldersArray in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.projectName = foldersArray?.profession.name
                    self?.checkAndAssignData(foldersArray?.folders)
                case .failure(let error):
                    if error.errorDescription == NetworkResponseError.internetError.errorDescription {
                        self?.isInternetConnected = false
                    }
                }
                if type == .refreshing { self?.refreshing = false }
            }
        }
    }
    
    private func fetchAllFolders(type: LoadPage) {
        DataFetcherServices.fetchAllFolders { [weak self] result, foldersArray in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.checkAndAssignData(foldersArray)
                case .failure(let error):
                    if error.errorDescription == NetworkResponseError.internetError.errorDescription {
                        self?.isInternetConnected = false
                    }
                }
                if type == .refreshing { self?.refreshing = false }
            }
        }
    }
    
    private func checkAndAssignData(_ foldersArray: [FolderModel]?) {
        guard let folders = foldersArray else { return }
        self.folders = folders
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

