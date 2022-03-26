//
//  ProfessionalSpheres.swift
//  Soulmate
//
//  Created by dasha on 30.11.2021.
//

import SwiftUI


struct ProfessionalSpheres: Hashable, Identifiable {
    var sphereName: String
    var icon: String
    
    var id = UUID().uuidString
    var size: CGFloat = 0
}
