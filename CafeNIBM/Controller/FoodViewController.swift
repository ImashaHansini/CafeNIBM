//
//  FoodViewController.swift
//  CafeNIBM
//
//  Created by Imasha on 4/19/21.
//

import UIKit
import Firebase

class FoodViewController: UIViewController {
    
    @IBOutlet weak var tblFood: UITableView!
    
    var ref: DatabaseReference!
    
    var foodItems: [FoodItem] = []
    var selectedFoodItem : FoodItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblFood.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodCellReuseIdentifier")
        ref = Database.database().reference()
        getFoodItemData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToViewFoodItem" {
            let destinationVC = segue.destination as! FoodItemViewController
            destinationVC.foodItem = selectedFoodItem
        }
    }

}
extension FoodViewController{
    func getFoodItemData() {
        ref.child("foodItems").observe(.value, with: {
            (snapshot) in
            
            if let data = snapshot.value {
                if let foodItems = data as? [String: Any] {
                    for item in foodItems{
                        if let foodInfo = item.value as? [String: Any] {
                            let singleFoodItem = FoodItem(
                                _id: "",
                                 foodName: foodInfo["name"] as! String,
                                 foodDescription: foodInfo["description"] as! String,
                                 foodPrice: foodInfo["price"] as! Double,
                                 discount: foodInfo["discount"] as! Int,
                                 image: foodInfo["image"] as! String,
                                 category: foodInfo["category"] as! String)
                            
                            self.foodItems.append(singleFoodItem)
                        }
                    }
                    
                    self.tblFood.reloadData()
                }
            }
        })
    }
}

extension FoodViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblFood.dequeueReusableCell(withIdentifier: "FoodCellReuseIdentifier", for: indexPath) as! FoodTableViewCell
        cell.setupView(foodItem: foodItems[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFoodItem = foodItems[indexPath.row]
        self.performSegue(withIdentifier: "HomeToViewFoodItem", sender: nil)
        
        
    }
}
