import UIKit

class RearViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var userName: UILabel!
    
    override func viewDidLoad() {
        DatabaseManager.getUserInfo { (userInfo) in
            if let userInfo = userInfo{
                self.userName.text = userInfo.name
            }
        }
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipedMenu(_:)))
        swipe.direction = .left
        self.view.addGestureRecognizer(swipe)
    }
    
    @objc func swipedMenu(_ sneder:UISwipeGestureRecognizer){
        self.showMenu()
    }
    
    private func showMenu(){
        if let vc = self.revealViewController(){
            vc.revealToggle(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RearTableViewCell
        // config cell
        cell.iconImageView.image = Constants.items[indexPath.row].image
        cell.titleLabel.text = Constants.items[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.showHome()
            break
        case 1:
            self.showCart()
            break
        case 2:
            self.showOrderStatus()
            break
        case 3:
            self.signOut()
            break
        default:
            return
        }
    }
    
    private func showHome(){
        let main = UIStoryboard(name: "Sign", bundle: nil)
        let vc = main.instantiateViewController(withIdentifier: "signVc")
        self.present(vc, animated: true, completion: nil)
    }
    
    private func showCart(){
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let vc = main.instantiateViewController(withIdentifier: "cart")
        self.present(vc, animated: true, completion: nil)
        
    }
    
    private func showOrderStatus(){
        let main = UIStoryboard(name: "Main", bundle: nil)
        let vc = main.instantiateViewController(withIdentifier: "orders")
        self.present(vc, animated: true, completion: nil)
    }
    
    private func signOut(){
        AuthManager.signOut()
        let main = UIStoryboard(name: "Sign", bundle: nil)
        let vc = main.instantiateViewController(withIdentifier: "signInVc")
        self.present(vc, animated: true, completion: nil)
    }
}
