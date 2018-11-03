//
//  CardView.swift
//  FlowerApp
//
//  Created by Mostafa AbdEl Fatah on 11/2/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import UIKit

class CardView: UIButton {

    override func awakeFromNib() {
        //self.clipsToBounds = true
        self.layer.cornerRadius = 10.0
        self.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 10
        self.layer.masksToBounds = false
    }

}
