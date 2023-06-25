//
//  CustemView.swift
//  to du list
//
//  Created by yacov touati on 21/06/2023.
//

import UIKit

enum FieldType {
    case Title
    case OnSwitch
}

class CustemView: UIView {
    
    @IBOutlet weak var titleData: UILabel!
    @IBOutlet weak var switchpressed: UISwitch!
    
    @IBAction func pressSwtich(_ sender: UISwitch) {
        
    }
}
