//
//  LocalFetchedDataManager.swift
//  MoviesApp
//
//  Created by Priyanka Ghosh on 21/10/24.
//

import Foundation

class LocalFetchedDataManager {
    
    static let shared = LocalFetchedDataManager()

    private init(){}
    // This is a generic function where will read our local json file.
    func readJSONFromFile<T: Decodable>(fileName: String, type: T.Type) -> T? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
