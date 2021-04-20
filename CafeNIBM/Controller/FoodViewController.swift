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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblFood.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodCellReuseIdentifier")
        ref = Database.database().reference()
        getFoodItemData()
    }

}

extension FoodViewController{
    func getFoodItemData() {
        ref.child("foodItems").observe(.value, with: {
            (snapshot) in
            
            if let data = snapshot.value {
                
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
    
    
}
