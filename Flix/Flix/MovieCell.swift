//
//  MovieCell.swift
//  Flix
//
//  Created by Langtian Qin on 2/6/18.
//  Copyright © 2018 Langtian Qin. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var PhotoView: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var OverviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
