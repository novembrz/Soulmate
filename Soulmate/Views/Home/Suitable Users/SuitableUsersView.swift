//
//  SuitableUsersView.swift
//  Soulmate
//
//  Created by dasha on 12.01.2022.
//

import SwiftUI

struct SuitableUsersView: View {
    
    @ObservedObject var viewModel: SuitableUsersViewModel
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 35) {
                    TitleBlock(viewTitle: "Из твоей среды")
                    gridBlock
                }
                .padding(.horizontal, Constants.horizontalInset)
                .padding(.bottom, Constants.bottomInset)
            }
            .background(Color.defaultBackground.ignoresSafeArea())
        }
        .onAppear {
            viewModel.fetchAllPeople()
        }
    }
    
    
    //MARK: - Grid Block
    
    var gridBlock: some View {
        VStack {
            if let suitableUsers = viewModel.suitableUsers {
                LazyVGrid(columns: viewModel.columnsArray, spacing: 12) {
                    ForEach(suitableUsers, id: \.self) { user in
                        ContentCard(name: user.firstName,
                                    lastName: user.lastName,
                                    description: user.userProfessions?
                                        .filter { $0.main }
                                        .first?.name ?? "",
                                    imageString: user.avatars?
                                        .filter { $0.main ?? false }
                                        .first?.link ?? "",
                                    height: UIScreen.height / 5.2
                        )
                    }
                }
            } else {
                Image("errorPlug")
                    .padding(.top, 70)
            }
        }
    }
}


//MARK: - Previews

struct SuitableUsersView_Previews: PreviewProvider {
    static var previews: some View {
        SuitableUsersView(viewModel: SuitableUsersViewModel())
    }
}
