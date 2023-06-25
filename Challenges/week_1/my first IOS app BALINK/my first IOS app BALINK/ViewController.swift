//
//  ViewController.swift
//  my first IOS app BALINK
//
//  Created by yacov touati on 14/06/2023.
//

import UIKit

class ViewController: UIViewController{
    
    var firstName: String?
    var lastName: String?
    var userName: String?
    var pasword: String?
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LOG IN"
    }
    
    
    //pass data to the next page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "towelcome" {
            let destinationVC = segue.destination as? WellcomeScreenViewController
            destinationVC?.namePassed = firstName ?? ""
        }
    }
    
    
    @IBAction func pressedFirstName(_ sender: UITextField) {
        if let FirstNameValue = sender.text {
            firstName = FirstNameValue
        } else {
            firstName = ""
        }
    }
    
    @IBAction func pressLastName(_ sender: UITextField) {
        if let lastNameValue = sender.text {
            lastName = lastNameValue
        } else {
            firstName = ""
        }
    }
    
    //chek the data that enter in the field
    @IBAction func pressedName(_ sender: UITextField) {
        if let nameValue = sender.text {
            firstName = nameValue
        } else {
            firstName = ""
        }
    }
    
    @IBAction func pressedPassword(_ sender: UITextField) {
        if let passwordValue = sender.text {
            pasword = passwordValue
        } else {
            pasword = ""
        }
    }
    
    
    func isValid(testStr: String) -> Bool {
        guard testStr.count > 3, testStr.count < 8 else { return false }
        
        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: testStr)
    }
    
    
    //check if tow field is not empty
    @IBAction func pressedLogin(_ sender: UIButton) {
        let valid = isValid(testStr: firstName ?? "")
        if valid {
            performSegue(withIdentifier: "towelcome", sender: self)
        } else {
            return
        }
    }
    
    func sendData(firstname: String, lastname: String, username: String, password: String) {
        let url = URL(string: "https://balink.onlink.dev/register")!
        
        let user = ["firstname":"fhfdfdj", "lastname":"fhfdfdfj", "username":"fhdffj@ffg.ttg", "password":"fdhfj"]
        let jsonData = try? JSONSerialization.data(withJSONObject: user)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                self.token = String(data: data, encoding: .utf8)  ?? ""
            }
            else {
                print("error")
            }
        }.resume()
        
    }

}


//extension ViewController {
//
//    // MARK: - RegexType
//    enum RegexType {
//        case none
//        case email                          // Example: "foo@example.com"
//        case minLetters(_ letters: Int)     // Example: "Al"
//        case minDigit(_ digits: Int)        // Example: "0612345"
//        case onlyLetters                    // Example: "ABDEFGHILM"
//        case onlyNumbers                    // Example: "132543136"
//
//        fileprivate var pattern: String {
//            switch self {
//            case .none:
//                return ""
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





//if let pressedValue = sender.tag {
//    switch pressedValue {
//    case 1:
//        saveFirstName = sender.text!
//    case 2:
//        savelastName = sender.text!
//    case 3:
//        saveUserName = sender.text!
//    case 4:
//        savePassword = sender.text!
//    default:
//        print("not value")
//    }
//}

