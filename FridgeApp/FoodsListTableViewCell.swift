//
//  FoodsListTableViewCell.swift
//  FridgeApp
//
//  Created by Chase Peers on 9/26/15.
//  Copyright © 2015 Chase Peers. All rights reserved.
//

import UIKit

class FoodsListTableViewCell: MGSwipeTableCell {
    
    @IBOutlet weak var FoodName: UILabel!
    @IBOutlet weak var FoodImageView: UIImageView!
    //@IBOutlet weak var FoodWeight: UILabel!
    @IBOutlet weak var FoodAmount: UILabel!
    @IBOutlet weak var FoodExpiry: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
