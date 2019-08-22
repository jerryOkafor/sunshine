//
//  ForcastPagerViewCell.swift
//  Sunshine
//
//  Created by Jerry Hanks on 22/08/2019.
//  Copyright © 2019 Jerry. All rights reserved.
//

import UIKit
import FSPagerView

class ForcastPagerViewCell: FSPagerViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
