//
//  WellcomeScreenViewController.swift
//  my first IOS app BALINK
//
//  Created by yacov touati on 15/06/2023.
//

import UIKit

//page welcome
class WellcomeScreenViewController: UIViewController {

    var namePassed: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "WELLCOME \(namePassed)"
    }
}
