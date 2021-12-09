//
//  SearchViewModel.swift
//  Soulmate
//
//  Created by dasha on 30.11.2021.
//

import Foundation


final class SearchViewModel: ObservableObject {
    
    @Published var searchText = ""
    @Published var isSearching = false
    
    func randomString() -> String {
        let words = ["Найди своё окружение", "Найди своё вдохновение", "Найди интересные проекты", "Найди своё комьюнити", "Найди лучшие работы"]
        return words.randomElement()!
    }
}
