//
//  Guitar.swift
//  guitarguitar
//
//  Created by Danya on 10/14/22.
//

import Foundation

struct Guitar: Decodable {
    
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
    
    let bodyShapes = ["1":"SStyle", "2": "TStyle", "3": "DoubleCut", "4":"Offset", "5":"HollowBody",
                      "6":"VStyle", "7":"SmallBody", "8":"Orchestral", "9":"SStyle", "10":"Dreadnought",
                      "11": "Jumbo", "12":"Explorer", "13":"SingleCut", "14":"Combo", "15":"Head",
                      "16":"Cabinet"]
    
    private enum CodingKeys: String, CodingKey {
        case skU_ID, asn, category, online, itemName, title, brandName, description,
             productDetail, salesPrice, pictureMain, qtyInStock, qtyOnOrder, colour,
             pickup, bodyShape, createdOn
    }
}
