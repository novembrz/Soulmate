//
//  MockService.swift
//  Soulmate
//
//  Created by dasha on 30.11.2021.
//

import Foundation

class MockService {
    
    static var professionArray: [UserProfessions] = [UserProfessions(name: "", main: false, id: 0, position: 0, totalWorks: 0)]
    
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
    
    static func followUser() {
        print(#function)
    }
}
