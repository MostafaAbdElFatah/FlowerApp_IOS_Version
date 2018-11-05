//
//  DetailsViewController.swift
//  FlowerApp
//
//  Created by Mostafa AbdEl Fatah on 11/2/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var payment = ""
    var flower:Flower!
    @IBOutlet weak var flowerImageView: UIImageView!
    @IBOutlet weak var flowerPrice: UILabel!
    @IBOutlet weak var flowerCategory: UILabel!
    @IBOutlet weak var flowerQuentity: UILabel!
    @IBOutlet weak var flowerinstructions: UILabel!
    // set some properties
    @IBOutlet weak var orderbtn: UIButton!{
        didSet{
            //self.orderbtn.clipsToBounds = true
            self.orderbtn.layer.cornerRadius = 25.0
            self.orderbtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            self.orderbtn.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            self.orderbtn.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.orderbtn.layer.shadowOpacity = 1
            self.orderbtn.layer.shadowRadius = 10
            self.orderbtn.layer.masksToBounds = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // set flower details
        self.navigationItem.title = flower.name
        self.flowerCategory.text = self.flower.category
        self.flowerPrice.text = "$\(self.flower.price)"
        self.flowerinstructions.text = self.flower.instructions
        // download image from server
        StorageManager.getImageURL(photo: self.flower.photo) { (url, error) in
            if let error = error{
                self.showAlert(title: "Image Error", message: error.localizedDescription)
            }else{
                self.flowerImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "loading"))
            }
        }
        
        // set swipe gesture recognizer
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipedMenu(_:)))
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
    }

    private func showMenu(){
        if let vc = self.revealViewController(){
            vc.revealToggle(animated: true)
        }
    }
    
    @objc func swipedMenu(_ sneder:UISwipeGestureRecognizer){
        self.showMenu()
    }
    
    @IBAction func showSideMenu(_ sender: Any) {
        self.showMenu()
    }
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        self.flowerQuentity.text = "\(Int(sender.value))"
    }
    
    @IBAction func orderbtnDidTapped(_ sender: Any) {
        if payment != "" {
            /// save order in database
            let quantity = Int(flowerQuentity.text!)!
            let totalPrice = flower.price * Float(quantity)
            let order = Order(id: "", flowerName: flower.name, payment: payment, quantity: quantity, status: false, totalPrice: totalPrice, discount: 0)
            DatabaseManager.saveOrder(order: order)
            self.showAlert(title: "Order Request", message: "Order added Successfully to Cart")
        }else{
            self.showAlert(title: "payment", message: "please payment method")
        }
    }
    
    @IBAction func paymentbtnDidTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Payment method", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "PayPal", style: .default, handler: { (alertAction) in
            self.payment = "PayPal"
        }))
        alert.addAction(UIAlertAction(title: "Credit Card", style: .default, handler: { (alertAction) in
            self.payment = "Credit Card"
        }))
        alert.addAction(UIAlertAction(title: "with delivery", style: .default, handler: { (alertAction) in
            self.payment = "with delivery"
        }))
        self.present(alert, animated: true, completion: nil)
    }
}










