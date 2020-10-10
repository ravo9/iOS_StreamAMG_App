//
//  VideoTableViewCell.swift
//  StreamAMG App
//
//  Created by Rafal Ozog on 10/10/2020.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var videoTitle: UILabel!
    
    var video : Video? {
        didSet {
            videoTitle.text = video?.metaData.title
        }
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
