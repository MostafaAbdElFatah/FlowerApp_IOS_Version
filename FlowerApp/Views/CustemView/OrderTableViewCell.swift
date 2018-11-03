//
//  OrderTableViewCell.swift
//  FlowerApp
//
//  Created by Mostafa AbdEl Fatah on 11/3/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var payment: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var address: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
