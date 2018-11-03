
import Foundation
import Firebase

struct DatabaseManager {
    
    private static let root = Database.database().reference()
    private static let users = root.child("users")
    private static let flowers = root.child("flowers")
    private static let orders = users.child(AuthManager.getUserId()!).child("orders")
    
    // MARK:- Save user info to firebase database
    static func saveUserInfo(userName:String, phone:String){
        let user = users.child(AuthManager.getUserId()!)
        user.child("name").setValue(userName)
        user.child("phone").setValue(phone)
        user.child("address").setValue("No ADDRESS")
    }
    // MARK:- save order in database
    static func saveOrder(order:Order){
        let dbOrder = orders.childByAutoId()
        dbOrder.setValue([ KeysNames.id:dbOrder.key!,
                           KeysNames.name:order.flowerName,
                           KeysNames.payment:order.payment,
                           KeysNames.discount:order.discount,
                           KeysNames.price:order.totalPrice,
                           KeysNames.quantity:order.quantity,
                           KeysNames.status:order.status])
    }
    
    // MARK:- get flowers list
    static func getFlowersList(completion:@escaping (_ flowersList:[Flower])->()){
        flowers.observeSingleEvent(of: .value) { (snapshot) in
            var flowers:[Flower] = []
            if let data = snapshot.value as? [String:AnyObject] {
                for value in data.values {
                    let id = value["productId"] as! Int
                    let name = value["name"] as! String
                    let category = value["category"] as! String
                    let price = (value["price"] as! NSNumber).floatValue
                    let photo = value["photo"] as! String
                    let instructions = value["instructions"] as! String
                    flowers.append(Flower(productId: id, name: name, photo: photo, category: category, price: price, instructions: instructions))
                }
                completion(flowers)
            }
        }
    }
    
    
}
