//
//  VideoViewCell.swift
//  StreamAMG App
//
//  Created by Rafal Ozog on 11/10/2020.
//

import UIKit

class VideoViewCell: UICollectionViewCell {
    
    @IBOutlet var corecategoriesLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    static let identifier = "VideoViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "VideoViewCell",
                     bundle: nil)
    }
    
    public func configure(with video: Video) {
        self.titleLabel.text = video.metaData.title.replacingOccurrences(of: " |", with: ",")
        let timeToDisplay = TimeFormatter().formatTimeToDisplay(
            timeInSeconds: video.metaData.videoDuration
        )
        self.timeLabel.text = timeToDisplay
        self.corecategoriesLabel.text = video.metaData.corecategories.joined(separator: " | ").uppercased()
        
        let url = URL(string: video.mediaData.thumbnailUrl)

        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            // TODO try catch
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data!)
            }
        }
    }
}
