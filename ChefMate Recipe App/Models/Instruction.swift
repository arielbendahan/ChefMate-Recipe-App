//
//  Instruction.swift
//  ChefMate Recipe App
//
//  Created by Ariel on 2025-03-23.
//

import Foundation


struct Instruction: Codable {
    let name: String
    let steps: [Step]
}
