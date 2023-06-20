//
//  dataCollectionViewCell.swift
//  to du list
//
//  Created by yacov touati on 18/06/2023.
//

import UIKit

class DataCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var dataLaebl: UILabel!
    
    func setup(backgroundColor: UIColor, cellData: String){
        self.backgroundColor = backgroundColor
        dataLaebl.text = cellData
    }
}
