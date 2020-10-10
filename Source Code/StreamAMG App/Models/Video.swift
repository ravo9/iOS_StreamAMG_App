//
//  Video.swift
//  StreamAMG App
//
//  Created by Rafal Ozog on 09/10/2020.
//

import Foundation

// MARK: - Video
struct Video: Decodable {
    let id: String
    let mediaData: MediaData
    let metaData: MetaData
    
    enum CodingKeys: String, CodingKey {
        case id
        case mediaData
        case metaData
    }
}

// MARK: - MediaData
struct MediaData: Decodable {
    let thumbnailUrl: String
    
    enum CodingKeys: String, CodingKey {
        case thumbnailUrl
    }
}

// MARK: - MetaData
struct MetaData: Decodable {
    let corecategories: [String]
    let videoDuration: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case corecategories
        case videoDuration = "VideoDuration"
        case title
    }
}
