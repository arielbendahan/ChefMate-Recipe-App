//
//  StripHTML.swift
//  ChefMate Recipe App
//
//  Created by Ariel on 2025-03-18.
//

import Foundation

extension String {
    var stripHTML: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
