//
//  SearchResponse.swift
//  JSONiTUNES
//
//  Created by Volodymyr Ostapyshyn on 16.12.2020.
//

import Foundation

struct SearchResponse: Decodable { //Decodable
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable { //Decodable
    var trackName: String
    var collectionName: String
    var artistName: String
    var artworkUrl60: String?
}


