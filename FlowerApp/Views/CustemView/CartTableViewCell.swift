//
//  CartTableViewCell.swift
//  FlowerApp
//
//  Created by Mostafa AbdEl Fatah on 11/3/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var flowerName: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    @IBOutlet weak var deleteOrderBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
