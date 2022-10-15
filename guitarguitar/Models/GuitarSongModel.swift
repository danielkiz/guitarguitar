//
//  GuitarSongModel.swift
//  guitarguitar
//
//  Created by Danya on 10/15/22.
//

import Foundation

struct GuitarSong: Decodable {
    let skU_ID: String?
    let spotifyId: String?
    let youtubeUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case skU_ID, spotifyId, youtubeUrl
    }
}
