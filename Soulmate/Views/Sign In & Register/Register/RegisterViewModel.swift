//
//  RegisterViewModel.swift
//  Soulmate
//
//  Created by dasha on 25.02.2022.
//

import Foundation
import UIKit


final class RegisterViewModel: ObservableObject {
    @Published var avatarImage: UIImage?
    @Published var name = ""
    @Published var lastName = ""
    @Published var city = ""
    @Published var birthDay = ""
    @Published var birthDate = Date()
    @Published var profession: [Int] = []
    @Published var usersMockProf: [ProfessionalSpheres] = [
        ProfessionalSpheres(sphereName: "Фотография", icon: "📸"),
        ProfessionalSpheres(sphereName: "Писательство", icon: "✍🏼"),
        ProfessionalSpheres(sphereName: "Музыка", icon: "🎸")
    ] //MARK: deplicated
    
    @Published var isPhotoPickerOpened = false
    @Published var isLoading = false
    @Published var isErrorAuth = false
    @Published var errorText: String?
    @Published var isSuccessReg = false
    @Published var successRegMessage = "Поздравляем! Вы создали аккаунт!"
    
    
    func registerUser() {
        isLoading = true
        AuthValidators.canFinishRegistration(name: name, lastName: lastName, birthDay: birthDay, city: city) { [weak self] result in
            switch result {
            case .success:
                self?.saveUserData()
            case .failure(let authError):
                self?.errorText = authError.errorDescription
                self?.isErrorAuth = true
                self?.isLoading = false
            }
        }
    }
    
    private func saveUserData() {
        self.isLoading = false
        isSuccessReg = true
    }
    
    
    
}
