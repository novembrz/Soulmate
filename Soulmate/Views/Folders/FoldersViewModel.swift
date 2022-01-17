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
    
    
    //MARK: - Fetch Data
    
    func fetchData(userProfessionId: Int?) {
        if userProfessionId != nil {
            DataFetcherServices.fetchUserProfessionFolders(id: userProfessionId!) { foldersArray in
                self.projectName = foldersArray?.profession.name
                self.checkAndAssignData(foldersArray?.folders)
            }
        } else {
            DataFetcherServices.fetchAllFolders { foldersArray in
                self.checkAndAssignData(foldersArray)
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
    
    func routeToUserDescription() {
        print(#function)
    }
    
    func openDetailBottomSheet() {
        print(#function)
    }
    
    func changeFolderView() {
        currentViewStyle = currentViewStyle == .stroke ? .rectangle : .stroke
    }
}

