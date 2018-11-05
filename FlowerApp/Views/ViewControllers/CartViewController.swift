//
//  OrdersViewController.swift
//  FlowerApp
//
//  Created by Mostafa AbdEl Fatah on 11/3/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var userInfo:UserInfo!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var ordersList:[Order] = [] {
        didSet{
            var price:Float = 0.0
            for item in self.ordersList {
                price += item.totalPrice
            }
            self.totalPriceLabel.text = "Total Orders Price: \(String(format: "%.2f", price))$"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseManager.getUserInfo { (userInfo) in
            if let userInfo = userInfo {
                self.userInfo = userInfo
            }
        }
        
        DatabaseManager.getOrdersList { (orders) in
            self.ordersList += orders.filter{ !$0.status }
            self.tableView.reloadData()
            self.activityIndicatorView.isHidden = true
        }
        
    }
    
    @IBAction func goBackToHome(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let vc = main.instantiateViewController(withIdentifier: "main_vc")
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func placeOrderAddress(_ sender: Any) {
        let alert = UIAlertController(title: "Payment method", message: nil, preferredStyle: .alert)
        alert.addTextField { (textfield) in
            textfield.placeholder = "place order Address"
        }
        alert.addAction(UIAlertAction(title: "OK", style:.default, handler: { (alertAction) in
            if let text = alert.textFields![0].text, text != "" {
                DatabaseManager.saveAddress(address: text)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.ordersList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CartTableViewCell
        // Configure the cell...
        cell.flowerName.text = self.ordersList[indexPath.row].flowerName
        cell.quantity.text = "Quantity: \(self.ordersList[indexPath.row].quantity)"
        cell.orderPrice.text = "\(String(format: "%.2f", self.ordersList[indexPath.row].totalPrice))$"
        cell.deleteOrderBtn.addTarget(self, action: #selector(deleteRow(_:)), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    @IBAction func deleteRow(_ sender: UIButton) {
        self.deleteOrder(row: sender.tag)
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.deleteOrder(row: indexPath.row)
        }
    }
    
    private func deleteOrder(row:Int){
        
        let alert = UIAlertController(title: "Deleting", message: "Are you sure you want to delete this order", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alertAction) in
            let indexPath = IndexPath(row: row, section: 0)
            // Delete the row from the data source
            DatabaseManager.removeOrder(order: self.ordersList[indexPath.row])
            self.ordersList.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}





