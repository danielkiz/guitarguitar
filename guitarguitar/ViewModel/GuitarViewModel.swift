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
    
    func searchGuitars(skU_ID: String = "", productDetail: String = "") -> [Guitar] {
        if skU_ID.isEmpty == false {
            var guitar: [Guitar] = GuitarData().guitarData.filter({ $0.skU_ID == skU_ID })
            return guitar
        } else if productDetail.isEmpty == false {
            var guitar: [Guitar] = GuitarData().guitarData.filter({ $0.productDetail == productDetail })
            return guitar
        }
        return guitars
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
