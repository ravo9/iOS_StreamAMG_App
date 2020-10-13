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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTableView.register(SectionViewCell.nib(), forCellReuseIdentifier: SectionViewCell.identifier)
        videoTableView.delegate = self
        videoTableView.dataSource = self
       
        setupViewModel()
        fetchVideos()
    }
    
    func setupViewModel(){
        self.feedViewModel = FeedViewModel(apiClient: APIClient())
        self.feedViewModel.dataFetchingSuccessHandling = {
            self.updateDataSource()
        }
        self.feedViewModel.dataFetchingErrorHandling = {
            self.displayErrorDialog()
        }
    }
    
    func fetchVideos(){
        self.feedViewModel.fetchVideos()
    }
    
    func updateDataSource(){
        DispatchQueue.main.async {
            self.videoTableView.dataSource = self
            self.videoTableView.reloadData()
        }
    }
    
    func displayErrorDialog() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Please try again", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: {_ in
                self.feedViewModel.refresh()
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feedViewModel.getNumberOfVideos()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = videoTableView.dequeueReusableCell(withIdentifier: SectionViewCell.identifier, for: indexPath) as! SectionViewCell
        
        cell.configure(with: feedViewModel.videosData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 288.0
    }
}
