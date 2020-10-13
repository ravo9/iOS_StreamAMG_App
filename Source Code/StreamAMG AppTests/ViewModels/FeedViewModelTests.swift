//
//  FeedViewModel.swift
//  Feed ViewModel Tests
//
//  Created by Rafal Ozog on 13/10/2020.
//

import XCTest
@testable import StreamAMG_App

class FeedViewModelTest: XCTestCase {
    
    var feedViewModel: FeedViewModel!
    
    var fakeVideosData = [Section]()
    
    var fakeVideosFetchingErrorState = NSError(domain:"", code:404, userInfo:nil)

    override func setUp() {
        super.setUp()
        
        // Prepare fake videos data
        let title = "fake/video/title"
        let videoDuration = 12345
        let corecategories = ["fake/video/corecategory"]
        let thumbnailUrl = "fake/thumbnail/url"
        let videoId = "fake/video/id"
        let sectionName = "fake/section/name"
        let sectionId = "fake/section/id"
        let fakeMetaData = MetaData(corecategories: corecategories, videoDuration: videoDuration, title: title)
        let fakeMediaData = MediaData(thumbnailUrl: thumbnailUrl)
        let fakeVideo = Video(id: videoId, mediaData: fakeMediaData, metaData: fakeMetaData)
        let fakeSection = Section(id: sectionId, name: sectionName, itemData: [fakeVideo])
        let sectionList = [fakeSection]
        fakeVideosData = sectionList
    }
    
    func testVideosCounter() {
        
        // SetupViewModel with the working dummy ApiClient
        feedViewModel = FeedViewModel(apiClient: DummyWorkingApiClient())

        // Set the videos within the ViewModel
        feedViewModel.videosData = fakeVideosData
        
        // Get videos amount
        let videosAmount = feedViewModel.getNumberOfVideos()

        // Check results
        XCTAssertEqual(1, videosAmount, "Amount of videos is not correct.")
        
        // Release the viewmodel
        feedViewModel = nil
    }

    func testVideosFetchingSuccessState() {
        
        // SetupViewModel with the working dummy ApiClient
        feedViewModel = FeedViewModel(apiClient: DummyWorkingApiClient())

        // Fetch videos
        feedViewModel.fetchVideos()
        
        // Check fetched data
        let fetchedVideos = feedViewModel.videosData

        // Check results
        let expectedVideosData = fakeVideosData
        XCTAssertEqual(expectedVideosData[0].id, fetchedVideos![0].id, "GetVideos did not fetch data correctly.")
        XCTAssertEqual(expectedVideosData[0].name, fetchedVideos![0].name, "GetVideos did not fetch data correctly.")
        XCTAssertEqual(expectedVideosData[0].itemData[0].metaData.title, fetchedVideos![0].itemData[0].metaData.title, "GetVideos did not fetch data correctly.")
        XCTAssertEqual(expectedVideosData[0].itemData[0].metaData.videoDuration, fetchedVideos![0].itemData[0].metaData.videoDuration, "GetVideos did not fetch data correctly.")
        XCTAssertEqual(expectedVideosData[0].itemData[0].metaData.corecategories.count, fetchedVideos![0].itemData[0].metaData.corecategories.count, "GetVideos did not fetch data correctly.")
        XCTAssertEqual(expectedVideosData[0].itemData[0].mediaData.thumbnailUrl, fetchedVideos![0].itemData[0].mediaData.thumbnailUrl, "GetVideos did not fetch data correctly.")
    }
    
    func testVideosFetchingErrorState() {
        
        // SetupViewModel with the non-working dummy ApiClient
        feedViewModel = FeedViewModel(apiClient: DummyNonWorkingApiClient())

        // Fetch videos
        feedViewModel.fetchVideos()
        
        // Check fetching error
        let fetchingError = feedViewModel.errorState as NSError

        // Check results
        let expectedFetchingErrorState = fakeVideosFetchingErrorState
        XCTAssertEqual(expectedFetchingErrorState.code, fetchingError.code, "Videos fetching error state is not handled correctly.")
        XCTAssertEqual(expectedFetchingErrorState.domain, fetchingError.domain, "Videos fetching error state is not handled correctly.")
    }
}

// Dummy Working ApiClient
class DummyWorkingApiClient: APIClient {
    override func getVideos(completion : @escaping (GetVideosResponse) -> (),
                   errorHandling : @escaping (Error) -> ()) {
        
        // Prepare videos data
        let title = "fake/video/title"
        let videoDuration = 12345
        let corecategories = ["fake/video/corecategory"]
        let thumbnailUrl = "fake/thumbnail/url"
        let videoId = "fake/video/id"
        let sectionName = "fake/section/name"
        let sectionId = "fake/section/id"
        let fakeMetaData = MetaData(corecategories: corecategories, videoDuration: videoDuration, title: title)
        let fakeMediaData = MediaData(thumbnailUrl: thumbnailUrl)
        let fakeVideo = Video(id: videoId, mediaData: fakeMediaData, metaData: fakeMetaData)
        let fakeSection = Section(id: sectionId, name: sectionName, itemData: [fakeVideo])
        let fakeGetVideosResponse = GetVideosResponse(sections: [fakeSection])
        
        // Mock success state
        completion(fakeGetVideosResponse)
    }
}

// Dummy Non-working ApiClient
class DummyNonWorkingApiClient: APIClient {
    override func getVideos(completion : @escaping (GetVideosResponse) -> (),
                   errorHandling : @escaping (Error) -> ()) {
        
        // Prepare error state
        let fakeErrorState = NSError(domain:"", code:404, userInfo:nil)
        
        // Mock error state
        errorHandling(fakeErrorState)
    }
}
