//
//  Model.swift
//  testproject
//
//  Created by yacov touati on 25/06/2023.
//

import Foundation

struct Posts: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
class FetchData {
    static let shared = FetchData()
    
    var postsArr :[Posts] = []
    
    func decodeAPI(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else{return}
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            let decoder = JSONDecoder()
            
            if let data = data{
                do{
                    let tasks = try decoder.decode([Posts].self, from: data)
                    self.postsArr = tasks
                    completion()
                }catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func getTitle()->[String] {
        return postsArr.map { $0.title }
    }
    
}
