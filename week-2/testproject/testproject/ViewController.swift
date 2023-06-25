//
//  ViewController.swift
//  testproject
//
//  Created by yacov touati on 25/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleTableView: UITableView!
    
    var titlesArr1 : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTableView.dataSource = self
        titleTableView.delegate = self
        
        FetchData.shared.decodeAPI {
            self.titlesArr1 = FetchData.shared.getTitle()
            DispatchQueue.main.async {
                self.titleTableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesArr1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
        
        cell.textLabel?.text = titlesArr1[indexPath.row]
        return cell
    }
}

