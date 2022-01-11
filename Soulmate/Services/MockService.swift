//
//  MockService.swift
//  Soulmate
//
//  Created by dasha on 30.11.2021.
//

import Foundation

class MockService {
    
    static var professionArray: [UserProfessions] = [UserProfessions(name: "", main: false, id: 0, position: 0)]
    
    static var friendsData = ["Petrov", "Avetisyan", "Azizova", "Dilan"]    
    
    static var professionalSpheres: [ProfessionalSpheres] = [
        ProfessionalSpheres(sphereName: "Фотография", icon: "📸"),
        ProfessionalSpheres(sphereName: "Писательство", icon: "✍🏼"),
        ProfessionalSpheres(sphereName: "Музыка", icon: "🎸"),
        ProfessionalSpheres(sphereName: "Кинопроизводство", icon: "🎞"),
        ProfessionalSpheres(sphereName: "Архитектура", icon: "🏛"),
        ProfessionalSpheres(sphereName: "Рукоделие", icon: "🧶"),
        ProfessionalSpheres(sphereName: "Дизайн", icon: "👩🏼‍🎨"),
        ProfessionalSpheres(sphereName: "Танцы", icon: "💃🏻")
    ]
    
    
    static var mockUser: UserModel = UserModel(id: 1, username: "username", firstName: "username", lastName: "username", city: "username", age: 16, color: "#FF0000", description: "username", views: 16, userProfessions: professionArray, avatars: [Avatars(link: "", main: true)], totalWorks: 16, totalSubscribers: 16, totalLikes: 16)
    
    
    static func followUser() {
        print(#function)
    }
}
