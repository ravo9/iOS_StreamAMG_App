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
        self.titleLabel.text = video.metaData.title
        let timeToDisplay = formatTimeToDisplay(
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
    
    private func formatTimeToDisplay(timeInSeconds: Int) -> String {
        let hours = Int(timeInSeconds) / 3600
        let minutes = Int(timeInSeconds) / 60 % 60
        let seconds = Int(timeInSeconds) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}
