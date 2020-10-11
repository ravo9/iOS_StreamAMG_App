//
//  VideoViewCell.swift
//  StreamAMG App
//
//  Created by Rafal Ozog on 11/10/2020.
//

import UIKit

class VideoViewCell: UICollectionViewCell {
    
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myImageVIew: UIImageView!
    
    static let identifier = "VideoViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "VideoViewCell",
                     bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with video: Video) {
        self.myLabel.text = video.metaData.title
    }

}
