//
//  ViewController.swift
//  calculator
//
//  Created by yacov toua           	                        i on 13/06/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var opera: String = ""
    var resu: Double?
    
    
    @IBOutlet weak var result: UILabel!
    
    
    @IBAction func NumberPressed(_ sender: UIButton) {
        result.text = sender.titleLabel?.text
    }
    
    @IBAction func equal(_ sender: UIButton) {
        guard let input =  sender.titleLabel?.text else {return}
        opera.append(input)
        print(opera)
    }
    @IBAction func point(_ sender: UIButton) {
        guard let input =  sender.titleLabel?.text else {return}
        opera.append(input)
        print(opera)
    }
    @IBAction func divide(_ sender: UIButton) {
        guard let input =  sender.titleLabel?.text else {return}
        opera.append(input)
        print(opera)
    }
    @IBAction func plus(_ sender: UIButton) {
        guard let input =  sender.titleLabel?.text else {return}
        opera.append(input)
        print(opera)
    }
    @IBAction func multiply(_ sender: UIButton) {
        guard let input =  sender.titleLabel?.text else {return}
        opera.append(input)
        print(opera)
    }
    @IBAction func minus(_ sender: UIButton) {
        uard let input =  sender.titleLabel?.text else {return}
        opera.append(input)
        print(opera)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

