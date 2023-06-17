//
//  ViewController.swift
//  my first IOS app BALINK
//
//  Created by yacov touati on 14/06/2023.
//

import UIKit

class ViewController: UIViewController{
    
    var getName: String = ""
    var getPassword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LOG IN"
    }
    
    
    //pass data to the next page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "towelcome" {
            let destinationVC = segue.destination as? WellcomeScreenViewController
            destinationVC?.namePassed = getName
        }
    }
    
    //chek the data that enter in the field
    @IBAction func pressedName(_ sender: UITextField) {
        if let nameValue = sender.text {
            getName = nameValue
        } else {
            getName = ""
        }
    }
    
    @IBAction func pressedPassword(_ sender: UITextField) {
        if let passwordValue = sender.text {
            getPassword = passwordValue
        } else {
            getPassword = ""
        }
    }
    
    
    func isValid(testStr: String) -> Bool {
        guard testStr.count > 3, testStr.count < 8 else { return false }
        
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: testStr)
    }
    
    
    //check if tow field is not empty
    @IBAction func pressedLogin(_ sender: UIButton) {
        let valid = isValid(testStr: getName)
        
        if valid {
            performSegue(withIdentifier: "towelcome", sender: self)
        } else {
            return
        }
        
        //        guard !getName.isEmpty, !getPassword.isEmpty else {
        //            return
        //        }
        //        //it's do the segue manuelye
        //        performSegue(withIdentifier: "towelcome", sender: self)
        //    }
    }
}
//extension String {
//
//    // MARK: - RegexType
//    enum RegexType {
//        case none
//        case mobileNumberWithItalianCode    // Example: "+39 3401234567"
//        case email                          // Example: "foo@example.com"
//        case minLetters(_ letters: Int)     // Example: "Al"
//        case minDigit(_ digits: Int)        // Example: "0612345"
//        case onlyLetters                    // Example: "ABDEFGHILM"
//        case onlyNumbers                    // Example: "132543136"
//        case noSpecialChars                 // Example: "Malago'": OK - "Malagò": KO
//
//        fileprivate var pattern: String {
//            switch self {
//            case .none:
//                return ""
//            case .mobileNumberWithItalianCode:
//                return #"^(\+39 )\d{9,}$"#
//            case .email:
//                return #"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$"#
//            case .minLetters(let letters):
//                return #"^\D{"# + "\(letters)" + #",}$"#
//            case .minDigit(let digits):
//                return #"^(\d{"# + "\(digits)" + #",}){1}$"#
//            case .onlyLetters:
//                return #"^[A-Za-z]+$"#
//            case .onlyNumbers:
//                return #"^[0-9]"#
//            case .noSpecialChars:
//                return #"^[A-Za-z0-9\s+\\\-\/?:().,']+$"#
//            }
//        }
//    }
//
//    // MARK: - Validation
//    /// Perform a regex falidation of the string
//    /// - Parameter regexType: enum type of the regex to use
//    /// - Returns: the result of the test
//    func isValidWith(regexType: RegexType) -> Bool {
//
//        switch regexType {
//        case .none : return true
//        default    : break
//        }
//
//        let pattern = regexType.pattern
//        guard let gRegex = try? NSRegularExpression(pattern: pattern) else {
//            return false
//        }
//
//        let range = NSRange(location: 0, length: self.utf16.count)
//
//        if gRegex.firstMatch(in: self, options: [], range: range) != nil {
//            return true
//        }
//
//        return false
//    }
//
//}
