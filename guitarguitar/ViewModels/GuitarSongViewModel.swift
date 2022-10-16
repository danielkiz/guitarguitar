//
//  GuitarSongViewModel.swift
//  guitarguitar
//
//  Created by Danya on 10/15/22.
//

import Foundation

class GuitarSongViewModel {
    
    let apiService = ApiService()
    var guitarSong = [GuitarSong]()
    
    func fetchGuitarSongsData(completion: @escaping () -> ()) {

        apiService.getGuitarSongsData { [weak self] (result) in 
            switch result {
            case .success(let listOf):
                self?.guitarSong = listOf
                completion()
            case .failure(let error):
                print("Error processing JSON data: \(error)")
            }
        }
    }
}
