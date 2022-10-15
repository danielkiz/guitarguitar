//
//  GuitarViewModel.swift
//  guitarguitar
//
//  Created by Danya on 10/15/22.
//

import Foundation

class GuitarViewModel {
    
    private let apiService = ApiService()
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
    
    func numberOfItemsInSection(section: Int) -> Int {
        if guitars.count != 0 {
            return guitars.count
        }
        return 0
    }
    
    func numberOfItemsInSectionHome() -> Int {
        return 8
    }
    
    func cellForAt(indexPath: IndexPath) -> Guitar {
        return guitars[indexPath.row]
    }
}
