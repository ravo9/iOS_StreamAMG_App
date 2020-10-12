//
//  ApiClient.swift
//  StreamAMG App
//
//  Created by Rafal Ozog on 10/10/2020.
//

import Foundation

// MARK: - APIClient
class APIClient :  NSObject {
    
    private let videosUrl = URL(string: "https://thefa-cm.streamamg.com/api/v1/a7abf1f6-b3d5-4dea-89f4-5141ff264bfa/6ln63lARRtIkiJF0LiyvQTBiKBtLmHscrT71Or3Mmc4wb85l8J/en/feed/d040fcda-0a39-4c25-b50e-2808f3308bde/sections/")!
    
    func getVideos(completion : @escaping (GetVideosResponse) -> (),
                   errorHandling : @escaping (Error) -> ()){
        URLSession.shared.dataTask(with: videosUrl) { (data, urlResponse, error) in
            if let data = data {
                
                let jsonDecoder = JSONDecoder()
                
                let videosData = try! jsonDecoder.decode(GetVideosResponse.self, from: data)
                completion(videosData)
            }
            
            if let error = error {
                errorHandling(error)
            }
        }.resume()
    }
}
