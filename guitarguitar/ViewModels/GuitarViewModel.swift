//
//  GuitarViewModel.swift
//  guitarguitar
//
//  Created by Danya on 10/15/22.
//

import Foundation

class GuitarViewModel {
    
    let apiService = ApiService()
    var guitars = [Guitar]()
    
    func fetchGuitarsData(completion: @escaping () -> ()) {
        apiService.getGuitarsData { [weak self] (result) in
            switch result {
            case .success(let guitarList):
                self?.guitars = guitarList
                completion()
            case .failure(let error):
                print("Error processing JSON data: \(error)")
            }
        }
    }
    
    func searchGuitarsData(identifier: String, completion: @escaping () -> ()) {
        apiService.getGuitarsData { [weak self] (result) in
            switch result {
            case .success(let guitarList):
                var searchedGuitars = [Guitar]()
                searchedGuitars += guitarList.filter {  $0.brandName == identifier }
                self?.guitars = searchedGuitars
                print(searchedGuitars)
                completion()
            case .failure(let error):
                print("Error processing JSON data: \(error)")
            }
        }
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        if guitars.count != 0 {
            return guitars.count
        }
        return 0
    }
    
    func cellForAt(indexPath: IndexPath) -> Guitar {
        return guitars[indexPath.row]
    }
    
}
