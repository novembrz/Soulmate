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
            RefreshableScrollView(refreshing: $viewModel.refreshing) {
                VStack(alignment: .leading, spacing: 35) {
                    TitleBlock(viewTitle: "Из твоей среды")
                    
                    if viewModel.isInternetConnected {
                        gridBlock
                    } else {
                        InternetConnectionView()
                    }
                }
                .padding(.horizontal, Constants.horizontalInset)
                .padding(.bottom, Constants.bottomInset)
            }
            .background(Color.defaultBackground.ignoresSafeArea())
        }
        .onAppear {
            viewModel.fetchAllPeople()
        }
        .onChange(of: viewModel.refreshing) { newValue in
            viewModel.fetchAllPeople(type: .refreshing)
        }
        .showLoading(isShowing: $viewModel.isLoading)
    }
    
    
    //MARK: - Grid Block
    
    var gridBlock: some View {
        VStack {
            if let suitableUsers = viewModel.suitableUsers {
                LazyVGrid(columns: viewModel.columnsArray, spacing: 12) {
                    ForEach(suitableUsers, id: \.self) { user in
                        ContentCard(name: user.firstName  ?? "", //отдаем работу или юзера а потом свитчером вызываем либо одну функцию заполнения либо другую
                                    id: user.id,
                                    lastName: user.lastName,
                                    description: user.professions?
                                        .filter { $0.main }
                                        .first?.name ?? "",
                                    imageString: user.avatars?
                                        .filter { $0.main ?? false }
                                        .first?.link ?? "",
                                    contentType: .user,
                                    height: UIScreen.height / 5.3
                        )
                    }
                }
            } else {
                Image("errorPlug")
                    .resizable()
                    .scaledToFit()
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
