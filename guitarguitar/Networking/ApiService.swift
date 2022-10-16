//
//  ApiService.swift
//  guitarguitar
//
//  Created by Danya on 10/15/22.
//

import Foundation

struct Constants {

    static let guitarsURL = "https://services.guitarguitar.co.uk/WebService/api/hackathon/guitars"
    static let guitarSongsURL = "https://services.guitarguitar.co.uk/WebService/api/hackathon/guitarswithsongs"
    
}

class ApiService {
    
    var dataTask: URLSessionDataTask?
    
    func getGuitarsData(completion: @escaping (Result<[Guitar], Error>) -> Void) {
        
        guard let url = URL(string: Constants.guitarsURL) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Guitar].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
    
    func getGuitarSongsData(completion: @escaping (Result<[GuitarSong], Error>) -> Void) {
        
        guard let url = URL(string: Constants.guitarSongsURL) else { return }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([GuitarSong].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }

}
