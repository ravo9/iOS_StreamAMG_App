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
    
    private var items : [Section]!
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
        if items != nil {
            return items.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = videoTableView.dequeueReusableCell(withIdentifier: SectionViewCell.identifier, for: indexPath) as! SectionViewCell
        
        cell.configure(with: items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 288.0
    }
    
    func callToViewModelForUIUpdate(){
        self.feedViewModel =  FeedViewModel()
        self.feedViewModel.bindFeedViewModelToController = {
            self.updateDataSource()
        }
    }
    
    func updateDataSource(){
        self.items = self.feedViewModel.videosData
        
        DispatchQueue.main.async {
            self.videoTableView.dataSource = self
            self.videoTableView.reloadData()
        }
    }
}
