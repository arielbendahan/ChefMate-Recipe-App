//
//  Filter.swift
//  ChefMate Recipe App
//
//  Created by english on 2025-03-13.
//

import Foundation

struct Filter: Identifiable, Hashable {
    enum FilterType {
        case cuisine
        case diet
        case ingredient
    }


    var id: UUID
    var name: String
    let type: FilterType
    
    init(name: String) {
        self.name = name
        self.id = UUID()
    }
    
    
    //For it to conform Equatable
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
