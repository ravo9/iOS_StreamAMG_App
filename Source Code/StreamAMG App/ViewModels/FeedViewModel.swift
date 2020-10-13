//
//  MainFeedViewModel.swift
//  StreamAMG App
//
//  Created by Rafal Ozog on 09/10/2020.
//

import Foundation

// MARK: - FeedViewModel
class FeedViewModel : NSObject {
    
    private var apiClient : APIClient!
    
    var videosData : [Section]! {
        didSet {
            self.dataFetchingSuccessHandling()
        }
    }
    
    var errorState : Error! {
        didSet {
            self.dataFetchingErrorHandling()
        }
    }
    
    var dataFetchingSuccessHandling : (() -> ()) = {}
    var dataFetchingErrorHandling : (() -> ()) = {}
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func fetchVideos() {
        self.apiClient.getVideos(
            completion: { (videosData) in
                self.videosData = videosData.sections
            },
            errorHandling: { (error) in
                self.errorState = error
            }
        )
    }
    
    func refresh() {
        fetchVideos()
    }
    
    func getNumberOfVideos() -> Int {
        if videosData != nil {
            return videosData.count
        } else {
            return 0
        }
    }
}
