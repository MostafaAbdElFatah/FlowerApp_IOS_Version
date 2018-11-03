import Foundation

struct Constants {
    static let items = [item(image:#imageLiteral(resourceName: "home-48"), title:"Home"), item(image:#imageLiteral(resourceName: "shopping-cart-24"), title:"Cart"), item(image:#imageLiteral(resourceName: "add-shopping-cart-24"), title:"Orders Status"), item(image:#imageLiteral(resourceName: "exit-26"), title:"Sign out")]
}

struct KeysNames {
    static let id = "id"
    static let name = "flowerName"
    static let payment = "payment"
    static let quantity = "quantity"
    static let status = "status"
    static let price = "totalPrice"
    static let discount = "discount"
}

struct item {
    var image:UIImage
    var title:String
}

class Order {
    var id:String = ""
    var flowerName:String = ""
    var payment:String = ""
    var quantity:Int = 1
    var status:Bool = false
    var totalPrice:Float = 0.0
    var discount:Int = 0
}

struct Flower {
    var productId:Int = 0
    var name:String = ""
    var photo:String = ""
    var category:String = ""
    var price:Float = 0.0
    var instructions = ""
}
