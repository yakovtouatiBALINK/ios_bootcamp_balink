//
//  managerequest.swift
//  my first IOS app BALINK
//
//  Created by yacov touati on 22/06/2023.
//

import Foundation
import UIKit

struct Product: Decodable {
       let id: Int?
       let title: String?
       let description: String?
       let price: Int?
       let discountPercentage: Double?
       let rating: Double?
       let stock: Int?
       let brand: String?
       let category: String?
       let thumbnail: String?
       let images: [String]?
}

func fetchProductFromAPI() async throws  -> [Product]{

    let url = URL(string: "https://balink.onlink.dev/products")!
    var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImZoZGpqZmZqQGZmZy50dGciLCJwYXNzd29yZCI6ImZkaGZqIiwiaWF0IjoxNjg3NDQ3NjAzfQ.yuld-SHMjajF2ZhCFJiGGkOUN3DXnbQ1_KH2NcfDLoM"

    var request = URLRequest(url: url)
    request.httpMethod = "GET"

    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

    let (data, _) = try await URLSession.shared.data(for: request)
    let decoded = try JSONDecoder().decode([Product].self, from: data)

    print(String(data: data, encoding: .utf8) ?? "")
    return decoded
}

Task {
    do {
        let product = try await fetchProductFromAPI()
        print(product)
    } catch {
        print(error)
    }
}

























//var token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6ImZoZGZmakBmZmcudHRnIiwicGFzc3dvcmQiOiJmZGhmaiIsImlhdCI6MTY4NzQzODIxMH0.3mNeN9VnfS1gR55Mygq3vhEsLORcSTByrabFDe9bvCo"

//var token = ""
//func sendData(firstname: String, lastname: String, username: String, password: String) {
//    let url = URL(string: "https://balink.onlink.dev/register")!
//
//    let user = ["firstname":"fhfdfdj", "lastname":"fhfdfdfj", "username":"fhdjjffj@ffg.ttg", "password":"fdhfj"]
//    let jsonData = try? JSONSerialization.data(withJSONObject: user)
//
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//
//    request.httpBody = jsonData
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//    URLSession.shared.dataTask(with: request) { data, response, error in
//        if let data = data {
//            token = String(data: data, encoding: .utf8)  ?? ""
//        }
//        else {
//            print("error")
//        }
//    }.resume()
//
//}
//
//sendData(firstname: "asd", lastname: "sdf", username: "sdf@asd.sdf", password: "zxc")







//func callAPI(){
//    guard let url = URL(string: "https://balink.onlink.dev/register") else{
//        return
//    }
//
//    let task = URLSession.shared.dataTask(with: url){
//        data, response, error in
//
//        if let data = data, let string = String(data: data, encoding: .utf8){
//            print(string)
//        }
//    }
//
//    task.resume()
//}

//func decodeAPI(){
//    guard let url = URL(string: "https://balink.onlink.dev/register") else{return}
//
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//
//    let params = [ ,"username": userName, "password": password,
//
//    let task = URLSession.shared.dataTask(with: url){
//        data, response, error in
//
//        let encoder = JSONEncoder()
//        let decoder = JSONDecoder()
//
//        if let data = data{
//            do{
//                let tasks = try decoder.decode([User].self, from: data)
//                tasks.forEach{ i in
//                    print(i.firstName)
//                }
//            }catch{
//                print(error)
//            }
//        }
//    }
//    task.resume()
//}









//MARK: delete
//func getToken(username: String, password: String, apiKey: String, completion: @escaping (String?, Error?) -> Void) {
//    // Create the URL
//    let url = URL(string: "https://api.example.com/token")!
//
//    // Create the request
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//
//    // Set the request body
//    let params = ["username": username, "password": password, "apiKey": apiKey]
//    let jsonData = try? JSONSerialization.data(withJSONObject: params)
//    request.httpBody = jsonData
//
//    // Set the request headers
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//    // Create the URLSession task
//    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//        // Handle the response
//        if let error = error {
//            completion(nil, error)
//            return
//        }
//
//        if let data = data,
//           let token = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//           let accessToken = token["access_token"] as? String {
//            completion(accessToken, nil)
//        } else {
//            completion(nil, nil)
//        }
//    }
//
//    // Start the URLSession task
//    task.resume()
//}
//
//// Usage
//getToken(username: "your_username", password: "your_password", apiKey: "your_api_key") { (token, error) in
//    if let error = error {
//        print("Error: \(error)")
//    } else if let token = token {
//        print("Token: \(token)")
//    } else {
//        print("Failed to retrieve token.")
//    }
//}

//In this example, you need to replace "https://api.example.com/token" with the actual URL of the API endpoint you're targeting. Additionally, provide the appropriate values for username, password, and apiKey when calling the getToken function.
//
//The getToken function takes the three variables as parameters and includes them in the JSON payload of the API request. It then handles the response from the server and extracts the access token if it exists. Finally, the token or an error is passed to the completion handler for further processing or error handling.



//import Foundation
//
//func getToken(username: String, password: String, apiKey: String, completion: @escaping (String?, Error?) -> Void) {
//    // Create the URL
//    let url = URL(string: "https://api.example.com/token")!
//
//    // Create the request
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//
//    // Set the request body
//    let params = ["username": username, "password": password, "apiKey": apiKey]
//    let requestData = try? JSONSerialization.data(withJSONObject: params)
//    request.httpBody = requestData
//
//    // Set the request headers
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//    // Send the request
//    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//        // Handle the response
//        if let error = error {
//            completion(nil, error)
//            return
//        }
//
//        if let data = data,
//           let token = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
//           let accessToken = token["access_token"] as? String {
//            completion(accessToken, nil)
//        } else {
//            completion(nil, nil)
//        }
//    }
//    task.resume()
//}
//
//// Usage
//getToken(username: "your_username", password: "your_password", apiKey: "your_api_key") { (token, error) in
//    if let error = error {
//        print("Error: \(error)")
//    } else if let token = token {
//        print("Token: \(token)")
//    } else {
//        print("Failed to retrieve token.")
//    }
//}
//This code is similar to the previous example. It creates a URLRequest with the desired endpoint URL and sets the HTTP method to "POST". The request body is populated with the variables passed as parameters in JSON format.
//
//The request is then sent using URLSession.shared.dataTask, and the response is handled similarly, extracting the access token from the JSON response.
//
//You can customize the endpoint URL and provide appropriate values for username, password, and apiKey when calling the getToken function.
//
//
//
//
//
//Regenerate response

