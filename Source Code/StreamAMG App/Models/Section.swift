//
//  Section.swift
//  StreamAMG App
//
//  Created by Rafal Ozog on 09/10/2020.
//

import Foundation

// MARK: - Section
struct Section: Decodable {
    let id: String
    let name: String
    let itemData: [Video]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case itemData
    }
}
