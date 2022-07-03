//
//  BusinessesModel.swift
//  searchForBusinesses
//
//  Created by anupam mishra on 26/06/22.
//

import Foundation

struct BusinessesResponse: Codable {
    let businesses: [BusinessesModel]
}

struct BusinessesModel: Codable {
    let id: String
    let alias: String?
    let name: String
    let image_url: String?
    let url: String
}
