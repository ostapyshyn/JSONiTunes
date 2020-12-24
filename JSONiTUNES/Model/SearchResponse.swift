//
//  SearchResponse.swift
//  JSONiTUNES
//
//  Created by Volodymyr Ostapyshyn on 16.12.2020.
//

import Foundation

struct SearchResponse: Codable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Codable { //Decodable
    var trackName: String
    var collectionName: String
    var artistName: String
    var artworkUrl60: String?
}
