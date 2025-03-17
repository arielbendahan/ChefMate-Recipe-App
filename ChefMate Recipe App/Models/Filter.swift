//
//  Filter.swift
//  ChefMate Recipe App
//
//  Created by english on 2025-03-13.
//

import Foundation

class Filter: Identifiable, Hashable {
    var id: UUID
    var name: String
    
    init(name: String) {
        self.name = name
        self.id = UUID()
    }
    
    func getEndpoint() -> String {
        fatalError("Subclasses must override this method")
    }
    
    //For it to conform Equatable
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

class CuisineFilter: Filter {
    override init(name: String) {
        super.init(name: name)
    }
    
    override func getEndpoint() -> String {
        return "";
    }
}

class DietFilter: Filter {
    override init(name: String) {
        super.init(name: name)
    }
    
    override func getEndpoint() -> String {
        return "";
    }
}

class IngredientsFilter: Filter {
    override init(name: String) {
        super.init(name: name)
    }
    
    override func getEndpoint() -> String {
        return "";
    }
}
