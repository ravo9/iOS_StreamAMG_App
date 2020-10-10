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
            self.bindFeedViewModelToController()
        }
    }
    
    var bindFeedViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiClient =  APIClient()
        getVideos()
    }
    
    func getVideos() {
        self.apiClient.getVideos { (videosData) in
            self.videosData = videosData.sections
        }
    }
}
