//
//  HomeViewModel.swift
//  Soulmate
//
//  Created by dasha on 30.11.2021.
//

import SwiftUI


final class HomeViewModel: ObservableObject {
    
    @Published var showProfileView = false
    @Published var showProjectsView = false
    @Published var professionalSpheres = MockService.professionalSpheres
    @Published var friendsData = MockService.friendsData
    
    let screenOffset: CGFloat = 26
    
}
