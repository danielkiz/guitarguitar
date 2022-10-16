//
//  Guitar.swift
//  guitarguitar
//
//  Created by Danya on 10/14/22.
//

import Foundation

class GuitarModel {
    let bodyShapes = ["1":"SStyle", "2": "TStyle", "3": "DoubleCut", "4":"Offset", "5":"HollowBody", "6":"VStyle", "7":"SmallBody", "8":"Orchestral", "9":"SStyle", "10":"Dreadnought", "11": "Jumbo", "12":"Explorer", "13":"SingleCut", "14":"Combo", "15":"Head", "16":"Cabinet"]
    let colours = ["1":"Red", "2":"Orange", "3":"Yellow", "4":"Green", "5":"Blue", "6":"Purple", "7":"Pink", "8":"Brown", "9":"Gold", "10":"Silver", "11":"Grey", "12":"Black", "13":"White", "14":"Natural", "15":"Multicolor"]
    let pickups = ["1":"ElectroAcoustic", "2":"SS", "3":"SSS", "4":"HH", "5":"HHH", "6":"HS", "7":"HSS", "8":"HSH", "9":"P90", "10":"S", "11":"H"]
}

struct Guitar: Codable {
    
    let skU_ID: String?
    let asn: String?
    let category: String?
    let online: Bool?
    let itemName: String?
    let title: String?
    let brandName: String?
    let description: String?
    let productDetail: String?
    let salesPrice: Double?
    let pictureMain: String?
    let qtyInStock: Int?
    let qtyOnOrder: Int?
    let colour: Int?
    let pickup: Int?
    let bodyShape: Int?
    let createdOn: String?
    
}

struct GuitarData: Decodable {
    var guitarData: [Guitar] = []
}
