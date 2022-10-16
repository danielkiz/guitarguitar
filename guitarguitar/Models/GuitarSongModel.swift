//
//  GuitarSongModel.swift
//  guitarguitar
//
//  Created by Danya on 10/15/22.
//

import Foundation

struct GuitarSong: Codable {
    
    let skU_ID: String?
    let spotifyId: String?
    let youtubeUrl: String?
    
}

struct GuitarSongData: Decodable {
    var songData: [GuitarSong] = []
}
