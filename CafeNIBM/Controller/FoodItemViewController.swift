//
//  FoodItemViewController.swift
//  CafeNIBM
//
//  Created by Imasha on 4/23/21.
//

import UIKit
import Kingfisher

class FoodItemViewController: UIViewController {

    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblFoodDescription: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
    
    var foodItem: FoodItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = self.foodItem {
            imgFood.kf.setImage(with: URL(string: item.image))
            lblFoodName.text = item.foodName
            lblFoodDescription.text = item.foodDescription
            lblFoodPrice.text = "LKR: \(item.foodPrice)"
            
        }
    }
    
    @IBAction func btnBackPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func btnAddToCart(_ sender: UIButton) {
        if let item = self.foodItem {
            CartHandler.foodItems.append(item)
        }
    
    }
}
