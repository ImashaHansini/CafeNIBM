//
//  OrderViewController.swift
//  CafeNIBM
//
//  Created by Imasha on 4/23/21.
//

import UIKit
import Firebase
import NotificationBannerSwift

class OrderViewController: UIViewController {

    @IBOutlet weak var tblOrders: UITableView!
    var orders: [Order] = []
    
    var  ref: DatabaseReference!
    let sessionMGR = SessionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        tblOrders.register(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderCellReuseIdentifier")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        getAllOrders()
    }
}

extension OrderViewController {
    func getAllOrders() {
        self.orders.removeAll()
        self.ref.child("orders")
           .child(sessionMGR.getUserData().userEmail
                   .replacingOccurrences(of: "@", with: "_")
                   .replacingOccurrences(of: ".", with: "_"))
            .observe(.value, with: {
                snapshot in
                if let data = snapshot.value {
                    if let orders = data as? [String: Any] {
                        for singleOrder in orders {
                            var placedOrder = Order()
                            placedOrder.orderID = singleOrder.key
                            if let orderInfo = singleOrder.value as? [String: Any] {
                                placedOrder.orderStatus = orderInfo["status"] as! String
                                if let orderItems = orderInfo["orderItems"] as? [Any] {
                                    for item in orderItems {
                                        if let itemInfo = item as? [String: Any] {
                                            placedOrder.orderTotal+=itemInfo["foodPrice"] as! Double
                                        }
                                    }
                                }
                            }
                            self.orders.append(placedOrder)
                        }
                        self.tblOrders.reloadData()
                    }
                }
        })
    }
           
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblOrders.dequeueReusableCell(withIdentifier: "OrderCellReuseIdentifier", for: indexPath) as! OrderTableViewCell
        cell.setupUI(order: orders[indexPath.row])
        return cell
    }
    
        
    }
    
   


