//
//  LeadCell.swift
//  MyAeroDoc
//
//  Created by Denis Karpenko on 02.05.15.
//  Copyright (c) 2015 Denis Karpenko. All rights reserved.
//

import UIKit

class LeadCell: UITableViewCell {
    @IBOutlet weak var topLabel: UILabel!

    @IBOutlet weak var bottomLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
