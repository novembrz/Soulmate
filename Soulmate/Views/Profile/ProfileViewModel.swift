//
//  ProfileViewModel.swift
//  Soulmate
//
//  Created by dasha on 20.11.2021.
//

import SwiftUI


final class ProfileViewModel: ObservableObject {
    
    @Published var user: UserModel?
    
    var personProfessions: [UserProfessions] { user?.userProfessions.sorted(by: { $0.position < $1.position }) ?? [] }
    @Published var columns: [ColumnModel] = []
    @Published var isAllowWritingMessages = true
    
    let maxHeigth = UIScreen.main.bounds.height / 1.32
    let width = UIScreen.main.bounds.size.width
    let screenOffset: CGFloat = 26
    let cardsOffset: CGFloat = 15
    
    var cardWidth: CGFloat { return (width - 2*screenOffset - 15) / 2 }
    var cardHeight: CGFloat { return cardWidth * 1.3 }
    
    //MARK: - Methods
    
    func fetchUser() {
        fetchData { [self] result in
            DispatchQueue.main.async {
                guard let userData = result else { return }
                user = userData
                self.createColumns()
            }
        }
    }
    
    private func fetchData(completion: @escaping (UserModel?) -> Void) {
        NetworkService.fetchData(urlString: "http://localhost:8080/api/user/3", completion: completion)
    }
    
    func columnIndex(of column: ColumnModel) -> Int {
        guard let index = columns.firstIndex(of: column) else { return 0 }
        return index
    }
    
    func createColumns() {
        var firstColumn = ColumnModel()
        var secondColumn = ColumnModel()
        
        //guard let professions = user?.userProfessions else { return }
        //let professions = professionsArray.sorted(by: { $0.position < $1.position })
        
        for prof in personProfessions {
            prof.position % 2 == 0 ? firstColumn.gridItems.append(prof) : secondColumn.gridItems.append(prof)
        }
        
        columns = [firstColumn, secondColumn]
    }
    
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
        ProfileView(viewModel: ProfileViewModel())
    }
}
