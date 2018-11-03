//
//  CartTableViewController.swift
//  FlowerApp
//
//  Created by Mostafa AbdEl Fatah on 11/3/18.
//  Copyright © 2018 Mostafa AbdEl Fatah. All rights reserved.
//

import UIKit

class OrdersTableViewController: UITableViewController {

    var userInfo:UserInfo!
    var ordersList:[Order] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseManager.getUserInfo { (userInfo) in
            if let userInfo = userInfo {
                self.userInfo = userInfo
                DatabaseManager.getOrdersList { (orders) in
                    self.ordersList += orders.filter{ $0.status }
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    @IBAction func goBackToHome(_ sender: Any) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let vc = main.instantiateViewController(withIdentifier: "main_vc")
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.ordersList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderTableViewCell
        // Configure the cell...
        cell.orderId.text = self.ordersList[indexPath.row].id
        cell.payment.text = self.ordersList[indexPath.row].payment
        cell.phoneNumber.text = self.userInfo.phone
        cell.address.text = self.userInfo.address
        return cell
    }
    
}
