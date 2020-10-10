//
//  GetVideosResponse.swift
//  StreamAMG App
//
//  Created by Rafal Ozog on 10/10/2020.
//

import Foundation

// MARK: - GetVideosResponse
struct GetVideosResponse: Decodable {
    let sections: [Section]
    
    enum CodingKeys: String, CodingKey {
        case sections
    }
}
