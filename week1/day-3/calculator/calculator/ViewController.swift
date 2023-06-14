//
//  ViewController.swift
//  calculator
//
//  Created by yacov touati on 13/06/2023.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var number: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        number.text = "0"    //  the number that we see in open rhe calculator
    }
    
    var num1: Double?
    var num2: Double?
    var operatorPrees: String?
    
    //function that show the number that pressed
    @IBAction func NumberPressed(_ sender: UIButton) {
        guard let num = sender.titleLabel?.text else {return}
        print(num)
        
        let currentText = number.text ?? ""
        if currentText == "0" {
            number.text = num
        } else {
            number.text = currentText + num
        }
    }
    //function that show the operator that pressed
    @IBAction func operatorPressd(_ sender: UIButton) {
        guard let operatorText = sender.titleLabel?.text else {return}
        
        num1 = Double(number.text ?? "0")
        operatorPrees = operatorText
        number.text = operatorPrees
    }
    
    
    func plus(_ num1: Double, _ num2: Double) -> Double {
        return num1 + num2
    }
    func minus(_ num1: Double, _ num2: Double) -> Double {
        return num1 - num2
    }
    func multiply(_ num1: Double, _ num2: Double) -> Double {
        return num1 * num2
    }
    func divide(_ num1: Double, _ num2: Double) -> Double? {
        guard num2 != 0 else {
            return nil
        }
        return num1 / num2
    }
    
    //function that calculate
    @IBAction func equal(_ sender: UIButton) {
        num2 = Double(number.text ?? "0")
        
        if let number1 = num1, let number2 = num2, let operatorText = operatorPrees {
            var result: Double?
            switch operatorText {
            case "+":
                result = plus(number1, number2)
            case "-":
                result = minus(number1, number2)
            case "*":
                result = multiply(number1, number2)
            case "/":
                result = divide(number1, number2)
            default:
                break
            }
            if let result = result {
                number.text = String(result)
            }
        }
        num1 = nil
        num2 = nil
        operatorPrees = nil
    }
    
    //function that delete all screne
    @IBAction func deleteAll(_ sender: UIButton) {
        number.text = "0"
    }
}
    
