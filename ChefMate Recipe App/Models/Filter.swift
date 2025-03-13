//
//  Filter.swift
//  ChefMate Recipe App
//
//  Created by english on 2025-03-13.
//

import Foundation

struct Filter {
    var id: Int
    var name: String
    var isSelected: Bool
    
    init(name: String, id: Int) {
        self.id = id
        self.name = name
        self.isSelected = false
    }
    
    mutating func switchIsSelected() {
        self.isSelected = !self.isSelected
    }
}
