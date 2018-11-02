//
//  moviewCell.swift
//  TestDemo
//
//  Created by Apple on 01/11/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class moviewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblMoviewName: UILabel!
    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var lblMoviewYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
