//
//  NetworkHandler.swift
//  Sports
//
//  Created by Mina on 12/05/2024.
//

import Foundation
import Foundation
protocol MyDecodable {
    func decode<T:Codable>(data: Data) -> T
}
protocol Fetchable {
    func fetchData(urlString: String, _ onComplete: @escaping (Data) -> Void)
}

class DataFetcher: Fetchable {
    static let shared = DataFetcher()
    private init() {}
    
    func fetchData(urlString: String, _ onComplete: @escaping (Data) -> Void) {
        let session = URLSession.shared
            
        let url = URL(string: urlString)!
        let task = session.dataTask(with: url) { data,resp,_ in
            let httpResponse = resp as? HTTPURLResponse
            print("response code: \(String(httpResponse!.statusCode))")
            if let data = data {
                onComplete(data)
            }
        }
        task.resume()
    }
}
class DataDecoder: MyDecodable {
    static let shared = DataDecoder()
    private init(){}
    func decode<T:Codable>(data: Data) -> T {
        let decoder = JSONDecoder()
        let decoded = try? decoder.decode(T.self, from: data)
        return decoded!
    }
}

