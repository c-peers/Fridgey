//
//  ExpireTableViewCell.swift
//  FridgeApp
//
//  Created by Chase Peers on 12/14/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class ExpireTableViewCell: UITableViewCell {

    @IBOutlet weak var expireFoodImage: UIImageView!
    @IBOutlet weak var expireFoodName: UILabel!
    @IBOutlet weak var expireFoodAmount: UILabel!
    @IBOutlet weak var expireFoodDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
