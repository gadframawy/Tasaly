//
//  MyCell.swift
//  Tasaly
//
//  Created by Envy on 5/8/20.
//  Copyright © 2020 framawy. All rights reserved.
//

import UIKit

class MyCell: UITableViewCell {

    @IBOutlet weak var movieDes: UITextView!
    @IBOutlet weak var movieName: UILabel?
    @IBOutlet weak var movieImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
