//
//  SoulmateApp.swift
//  Soulmate
//
//  Created by dasha on 20.11.2021.
//

import SwiftUI

@main
struct SoulmateApp: App {
    var body: some Scene {
        WindowGroup<MainView> {
            MainView(viewModel: MainViewModel())
        }
    }
}
