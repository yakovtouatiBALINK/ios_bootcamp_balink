//
//  dataCollectionViewCell.swift
//  to du list
//
//  Created by yacov touati on 18/06/2023.
//

import UIKit
import CoreData
class DataCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dataLaebl: UILabel!
    
    func setup(backgroundColor: UIColor, cellData: NSManagedObject){
        self.backgroundColor = backgroundColor
        dataLaebl.text = cellData.value(forKey: "task") as! String
    }
}
