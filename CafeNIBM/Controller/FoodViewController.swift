//
//  FoodViewController.swift
//  CafeNIBM
//
//  Created by Imasha on 4/19/21.
//

import UIKit

class FoodViewController: UIViewController {
    
    @IBOutlet weak var tblFood: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension FoodViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
