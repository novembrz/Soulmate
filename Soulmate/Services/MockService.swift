//
//  MockService.swift
//  Soulmate
//
//  Created by dasha on 30.11.2021.
//

import Foundation

class MockService {
    
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
    
    static var mockProfessionArray: [UserProfessions] = [UserProfessions(id: 1, name: "name", main: true, position: 1, userProfessionId: 1, worksCount: 1, folderCount: 1)]
    
    static var mockUser: UserModel = UserModel(id: 1, username: "username", firstName: "username", lastName: "username", professions: mockProfessionArray, avatars: [Avatars(link: "", main: true)], city: "username", age: 16, color: "#FF0000", description: "username", views: 16, totalWorks: 16, totalSubscribers: 16, totalLikes: 16)
    
    static var mockFolder: FolderModel = FolderModel(id: 1, previewPictures: ["Petrov, Dilan, Azizova"], name: "Концепция феминистического сериала по «1984» Дж. Оруэлла", author: mockUser)
    
    
    static func followUser() {
        print(#function)
    }
}
