//
//  SectionViewCell.swift
//  StreamAMG App
//
//  Created by Rafal Ozog on 11/10/2020.
//

import UIKit

class SectionViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,
                               UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var headerLabel: UILabel!
    
    @IBOutlet var collectionView: UICollectionView!
    
    var videos = [Video]()
    
    static let identifier = "SectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "SectionViewCell",
                     bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(VideoViewCell.nib(), forCellWithReuseIdentifier: VideoViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configure(with section: Section) {
        headerLabel.text = section.name
        self.videos = section.itemData
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoViewCell.identifier, for: indexPath) as! VideoViewCell
        cell.configure(with: videos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 214)
    }
    
}
