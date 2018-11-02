//
//  SignViewController.swift
//  FlowerApp
//
//  Created by Mostafa AbdEl Fatah on 11/1/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import UIKit

class SignViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        AuthServices.authChanged { (auth, user) in
            /// present flowers view contoller
            if user != nil{
                let main = UIStoryboard(name: "Main", bundle: nil)
                let flowersVc = main.instantiateViewController(withIdentifier: "flowerslist")
                self.navigationController?.pushViewController(flowersVc, animated: true)
            }
        }
    }

}
