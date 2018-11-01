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
        // Initialization code
        containerView.layer.cornerRadius = 7.0
        containerView.layer.shadowOffset = CGSize(width:0, height:8)
        containerView.layer.shadowOpacity = 0.8
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
