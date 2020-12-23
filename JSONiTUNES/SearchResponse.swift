//
//  SearchResponse.swift
//  JSONiTUNES
//
//  Created by Volodymyr Ostapyshyn on 16.12.2020.
//

import Foundation

struct SearchResponse {
    var resultCount: Int
    var results: [Track]
}

struct Track {
    var trackName: String
    var collectionName: String
    var artistName: String
    var artworkUrl60: String?
}


