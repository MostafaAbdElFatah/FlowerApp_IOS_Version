import UIKit
import SDWebImage


class FlowersViewController: UIViewController {

    var indexPath:IndexPath!
    var flowersList:[Flower] = []
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipedMenu(_:)))
        swipe.direction = .right
        self.view.addGestureRecognizer(swipe)
    }
   
    private func loadData(){
        DatabaseManager.getFlowersList { (flowers) in
            self.flowersList += flowers
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    
    @IBAction func showSideMenuDidTapped(_ sender: Any) {
        self.showMenu()
    }
    
    @objc func swipedMenu(_ sneder:UISwipeGestureRecognizer){
        self.showMenu()
    }
    
    private func showMenu(){
        if let vc = self.revealViewController(){
            vc.revealToggle(animated: true)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if let details = segue.destination as? DetailsViewController {
            // Pass the selected object to the new view controller.
            details.flower = self.flowersList[self.indexPath.row]
        }
    }
    

}


extension FlowersViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.flowersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FlowerTableViewCell
        // config cell
        StorageManager.getImageURL(photo: self.flowersList[indexPath.row].photo) { (url, error) in
            if let error = error{
                self.showAlert(title: "Image Error", message: error.localizedDescription)
            }else{
                cell.flowerImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "loading"))
                //cell.flowerImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "loading"))
            }
        }
        cell.flowerNameLabel.text = self.flowersList[indexPath.row].name
        cell.flowerCategoryLabel.text = self.flowersList[indexPath.row].category
        cell.flowerPriceLabel.text = "$\(self.flowersList[indexPath.row].price)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.indexPath = indexPath
        return indexPath
    }
    
}
















