//
//  FeedViewController.swift
//  StreamAMG App
//
//  Created by Rafal Ozog on 10/10/2020.
//

import Foundation
import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var videoTableView: UITableView!
    
    private var feedViewModel : FeedViewModel!
    
    private var dataSource : VideoTableViewDataSource<SectionViewCell, Video>!
    
    var tempVideos = [Video]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTableView.register(SectionViewCell.nib(), forCellReuseIdentifier: SectionViewCell.identifier)
        videoTableView.delegate = self
        videoTableView.dataSource = self
        
        tempVideos.append(Video(id: "01", mediaData: MediaData(thumbnailUrl: "http"), metaData: MetaData(corecategories: [String](), videoDuration: 12, title: "Fake Title")))
        
        tempVideos.append(Video(id: "02", mediaData: MediaData(thumbnailUrl: "http"), metaData: MetaData(corecategories: [String](), videoDuration: 22, title: "Fake Title 2")))
        
        tempVideos.append(Video(id: "03", mediaData: MediaData(thumbnailUrl: "http"), metaData: MetaData(corecategories: [String](), videoDuration: 32, title: "Fake Title 3")))
        
        callToViewModelForUIUpdate()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource != nil {
            return dataSource.getItemsAmount()
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = videoTableView.dequeueReusableCell(withIdentifier: SectionViewCell.identifier, for: indexPath) as! SectionViewCell
        
        cell.configure(with: tempVideos)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
    func callToViewModelForUIUpdate(){
        
        self.feedViewModel =  FeedViewModel()
        self.feedViewModel.bindFeedViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        
        self.dataSource = VideoTableViewDataSource(cellIdentifier: "SectionViewCell", items: self.feedViewModel.videosData[0].itemData, configureCell: { (cell, video) in
//            cell.videoTitle.text = video.metaData.title
        })
        
        DispatchQueue.main.async {
            self.videoTableView.dataSource = self.dataSource
            self.videoTableView.reloadData()
        }
    }
    
}


class VideoTableViewDataSource<CELL : UITableViewCell,T> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func getItemsAmount() -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        let item = self.items[indexPath.row]
        self.configureCell(cell, item)
        return cell
    }
}
