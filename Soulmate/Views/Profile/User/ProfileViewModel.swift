//
//  ProfileViewModel.swift
//  Soulmate
//
//  Created by dasha on 20.11.2021.
//

import SwiftUI


final class ProfileViewModel: ObservableObject {
    
    @Published var user: UserModel?
    @Published var columns: [ColumnModel] = []
    @Published var isAllowWritingMessages = true
    @Published var isInternetConnected = true
    @Published var refreshing = false
    
    var ageString: String { user?.age == nil ? "" : "\(user?.age ?? 0)" }
    var description: String { "\(user?.city ?? ""), \(ageString)"}
    var title: String { "\(user?.firstName ?? "")\n\(user?.lastName ?? "")" }
    
    var personProfessions: [UserProfessions] { user?.professions?.sorted(by: { $0.position < $1.position }) ?? [] }
    
    let defaultHex = "9AC5BC"
    
    let maxHeigth = UIScreen.main.bounds.height / 1.32
    let width = UIScreen.main.bounds.size.width
    let cardsOffset: CGFloat = 15
    var cardWidth: CGFloat { return (width - 2*Constants.horizontalInset - 15) / 2 }
    var cardHeight: CGFloat { return cardWidth * 1.3 }
    
    
    //MARK: - Fetch
    
    func fetchUser(_ userId: Int, type: LoadPage = .loading) {
        DataFetcherServices.fetchUser(id: userId) { [weak self] result, userData in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    guard let userData = userData else { return }
                    self?.user = userData
                    self?.createColumns()
                case .failure(let error):
                    if error.errorDescription == NetworkResponseError.internetError.errorDescription {
                        self?.isInternetConnected = false
                    }
                }
                if type == .refreshing { self?.refreshing = false }
            }
        }
    }
    
    
    // MARK: - Column
    
    func columnIndex(of column: ColumnModel) -> Int {
        guard let index = columns.firstIndex(of: column) else { return 0 }
        return index
    }
    
    func createColumns() {
        var firstColumn = ColumnModel()
        var secondColumn = ColumnModel()
        
        for prof in personProfessions {
            prof.position % 2 == 0 ? firstColumn.gridItems.append(prof) : secondColumn.gridItems.append(prof)
        }
        
        columns = [firstColumn, secondColumn]
    }
    
    
    // MARK: - Actions
    
    func subscribeUser() {
        //userService.followUser()

        //TODO: Right routing / Right Services
    }
    
    func routeToMessage() {
        print(#function)
    }
    
    func routeToUserDescription() {
        print(#function)
    }
}

//MARK: - Previews

struct ProfileViewModel_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userId: 2, viewModel: ProfileViewModel())
    }
}
