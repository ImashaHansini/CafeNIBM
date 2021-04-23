//
//  OrderTableViewCell.swift
//  CafeNIBM
//
//  Created by Imasha on 4/23/21.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var lblOrderID: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(order: Order) {
        lblOrderID.text = order.orderID
        lblStatus.text = order.orderStatus
        lblTotal.text = "LKR \(order.orderTotal)"
    }
    
}
