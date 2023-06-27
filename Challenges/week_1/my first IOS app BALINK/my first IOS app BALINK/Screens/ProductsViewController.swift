//
//  ProductsViewController.swift
//  my first IOS app BALINK
//
//  Created by yacov touati on 15/06/2023.
//

import UIKit

// this is the last page
class ProductsViewController: UIViewController, UITableViewDataSource {
    
    var namePassed: String = ""
    let products = ["Apple Watch", "MacBook Pro", "IPhone 14 pro", "Airpods Pro", "Apple Keyboard"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "WELLCOME \(namePassed)"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = products[indexPath.row]
        return cell
    }
}



// display the data that come from the view model in the cell
