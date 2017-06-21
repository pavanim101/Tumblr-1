//
//  PhotoCell.swift
//  Tumblr
//
//  Created by Dominique Adapon on 6/21/17.
//  Copyright © 2017 Dominique Adapon. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    
    @IBOutlet weak var imageDisplay: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
