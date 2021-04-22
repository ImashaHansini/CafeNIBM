//
//  FoodTableViewCell.swift
//  CafeNIBM
//
//  Created by Imasha on 4/19/21.
//

import UIKit
import Kingfisher

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var viewContainerDiscount: UIView!
    @IBOutlet weak var lblDiscount: UILabel!
    
    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var lblFoodDescription: UILabel!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var imgFood: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

        func setupView(foodItem: FoodItem) {
            lblFoodName.text = foodItem.foodName
            lblFoodDescription.text = foodItem.foodDescription
            lblFoodPrice.text = "LKR \(foodItem.foodPrice)"
            imgFood.kf.setImage(with: URL(string: foodItem.image))
            
            if foodItem.discount > 0 {
                viewContainerDiscount.isHidden = false
                lblDiscount.text = "\(foodItem.discount)%"
            } else {
                viewContainerDiscount.isHidden = true
                lblDiscount.text = ""
            }
        }
        
    }
    

