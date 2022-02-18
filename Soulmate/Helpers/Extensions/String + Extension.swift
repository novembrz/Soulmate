//
//  String + Extension.swift
//  Soulmate
//
//  Created by dasha on 18.02.2022.
//

import Foundation

extension String {
    func withId(_ id: Int) -> String {
        return self + "/\(id)"
    }
}
