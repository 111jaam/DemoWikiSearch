//
//  WikiSearchTableViewCell.swift
//  DemoWikiSearch
//
//  Created by Bharat Byan on 23/07/18.
//  Copyright © 2018 Bharat Byan. All rights reserved.
//

import UIKit

class WikiSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
