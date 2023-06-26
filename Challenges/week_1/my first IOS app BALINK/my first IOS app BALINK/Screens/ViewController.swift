//
//  ViewController.swift
//  my first IOS app BALINK
//  Created by yacov touati on 14/06/2023.

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!

    @IBOutlet weak var login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LOG IN"
    }
    
    @IBAction func pressedLogin(_ sender: UIButton) {
        let valid = isValid(testStr: firstName ?? "") 
        if valid {
            performSegue(withIdentifier: "towelcome", sender: self)
        } else {
            return
        }
    }
    
    
    
    //pass data to the next page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "towelcome" {
            let destinationVC = segue.destination as? WellcomeScreenViewController
            destinationVC?.namePassed = firstName ?? ""
        }
    }
    
      
    
    
   
}

















