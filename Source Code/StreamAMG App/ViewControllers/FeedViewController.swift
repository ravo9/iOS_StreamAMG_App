//
//  FeedViewController.swift
//  StreamAMG App
//
//  Created by Rafal Ozog on 10/10/2020.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var videoTableView: UITableView!
    
    private var feedViewModel : FeedViewModel!
    
    private var dataSource : VideoTableViewDataSource<VideoTableViewCell, Video>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        callToViewModelForUIUpdate()
    }
    
    func callToViewModelForUIUpdate(){
        
        self.feedViewModel =  FeedViewModel()
        self.feedViewModel.bindFeedViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        
        self.dataSource = VideoTableViewDataSource(cellIdentifier: "VideoTableViewCell", items: self.feedViewModel.videosData[0].itemData, configureCell: { (cell, video) in
            cell.videoTitle.text = video.metaData.title
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
