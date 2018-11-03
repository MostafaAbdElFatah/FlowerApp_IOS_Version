import Foundation
import FirebaseAuth

struct AuthManager {
    
    // MARK: - create account in firebase
    static func signUp(email:String, userName:String,phone:String, password:String, completion:@escaping (String)->()){
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                print("AUTH ERROR:\(error)")
                completion("\(error.localizedDescription)")
            }else if Auth.auth().currentUser != nil {
                // save username and phone to database
                DatabaseManager.saveUserInfo(userName: userName, phone: phone)
            }
        }
    }
    
    // MARK:- log in to an existing account
    static func signIn(email:String, password:String, completion:@escaping (String)->()){
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            if let error = error {
                print("AUTH ERROR:\(error)")
                completion("\(error.localizedDescription)")
            }
        }
    }
    // MARK:- get user info
    static func getUserId()->String?{
        return Auth.auth().currentUser?.uid
    }
    
    static func getUser()->User?{
        return Auth.auth().currentUser
    }
    
    // MARK:- when auth changed
    static func authChanged(completion:@escaping (Auth,User?)->()){
        Auth.auth().addStateDidChangeListener { (auth, user) in
            completion(auth, Auth.auth().currentUser)
        }
    }
    // MARK:- log out from account
    static func signOut(){
        try? Auth.auth().signOut()
    }
    
    
}
