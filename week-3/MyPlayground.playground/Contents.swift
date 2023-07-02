//
//
//import Foundation
//
//struct User: Codable {
//    let firstname: String?
//    let lastname: String?
//    let username: String?
//    let password: String?
//}
//
//func createUser(firstname: String, lastname: String, username: String, password: String) async throws -> String {
//    let url = URL(string: "https://balink.onlink.dev/users/register")
//
//    let user = User(firstname: firstname, lastname: lastname, username: username, password: password)
//
//
//    var request = URLRequest(url: url!)
//    request.httpMethod = "POST"
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.httpBody = try JSONEncoder().encode(user)
//
//    let (data, response) = try await URLSession.shared.data(for: request)
//    let httpResponse = response as? HTTPURLResponse
//
//
//    let token = try getToken(from: data)
//    return token
//}
//
//
//func getToken(from data: Data) throws -> String {
//        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//        guard let token = jsonResponse?["token"] as? String else {
//            throw APIError.tokenNotFound
//        }
//        return token
//    }
//
//
//createUser(firstname: "dgtdt", lastname: "vdgbdf", username: "ertdfg", password: "efvgy")
//
//enum APIError: Error {
//    case invalidURL
//    case invalidResponse
//    case tokenNotFound
//    case registrationFailed(code: Int, message: String)
//}
//
//struct ErrorResponse: Codable {
//    let message: String
//}
//
//
////if let token = UserDefaults.standard.string(forKey: "AuthToken") {
////    print(token)
////}
//


import Foundation

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case tokenNotFound
    case registrationFailed(code: Int, message: String)
}

struct UserAPI {
    static func createUser(firstname: String, lastname: String, username: String, password: String, completion: @escaping (Result<String, APIError>) -> Void) {
        guard let url = URL(string: "https://balink.onlink.dev/users/register") else {
            completion(.failure(.invalidURL))
            return
        }
        
        let user = User(firstname: firstname, lastname: lastname, username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let captureRequest = request // Create a separate variable to capture request
        
        DispatchQueue.global().async {
            async {
                do {
                    let (data, response) = try await URLSession.shared.data(for: captureRequest)
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(.failure(.invalidResponse))
                        return
                    }
                    
                    if httpResponse.statusCode == 200 {
                        let token = try getToken(from: data)
                        completion(.success(token))
                    } else {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completion(.failure(.registrationFailed(code: httpResponse.statusCode, message: errorResponse.message)))
                    }
                } catch {
                    completion(.failure(.registrationFailed(code: -1, message: error.localizedDescription)))
                }
            }
        }
    }
    
    static func getToken(from data: Data) throws -> String {
        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        guard let token = jsonResponse?["token"] as? String else {
            throw APIError.tokenNotFound
        }
        return token
    }
}

struct User {
    let firstname: String
    let lastname: String
    let username: String
    let password: String
}

struct ErrorResponse: Codable {
    let message: String
}

// Example usage
UserAPI.createUser(firstname: "John", lastname: "Doe", username: "jdoe@example.com", password: "password") { result in
    switch result {
    case .success(let token):
        print("User registered successfully with token:", token)
    case .failure(let error):
        print("Registration failed with error:", error)
    }
}
