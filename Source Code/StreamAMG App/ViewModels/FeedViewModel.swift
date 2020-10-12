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
    
    private(set) var videosData : [Section]! {
        didSet {
            self.dataFetchingSuccessHandling()
        }
    }
    
    private(set) var errorState : Error! {
        didSet {
            self.dataFetchingErrorHandling()
        }
    }
    
    var dataFetchingSuccessHandling : (() -> ()) = {}
    var dataFetchingErrorHandling : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiClient =  APIClient()
        getVideos()
    }
    
    func refresh() {
        getVideos()
    }
    
    private func getVideos() {
        self.apiClient.getVideos(
            completion: { (videosData) in
                self.videosData = videosData.sections
            },
            errorHandling: { (error) in
                self.errorState = error
            }
        )
    }
    
    func getNumberOfVideos() -> Int {
        if videosData != nil {
            return videosData.count
        } else {
            return 0
        }
    }
}
