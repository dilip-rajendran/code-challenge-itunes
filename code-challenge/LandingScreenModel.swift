//
//  LandingScreenModel.swift
//  code-challenge
//
//  Created by Dilip on 3/25/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import Foundation

struct ResponseModel: Decodable {
    let feed: FeedModel?
    init(feed: FeedModel? = nil) {
        self.feed = feed
    }
}
struct FeedModel: Decodable {
    let title: String?
    let icon: String?
    let updated: String?
    let results: [resultsModel]?
    init(title: String? = nil,
         icon: String? = nil,
         updated: String? = nil,
         results: [resultsModel]? = nil) {
        self.title = title
        self.icon = icon
        self.updated = updated
        self.results = results
    }
}
struct resultsModel: Decodable {
    let artistName: String?
    let releaseDate: String?
    let copyright: String?
    let artworkUrl100: String?
    let name: String?
    let genres: [GenreModel]?
    let url: String?
    init(artistName: String? = nil,
         releaseDate: String? = nil,
         copyright: String? = nil,
         artworkUrl100: String? = nil,
         name: String? = nil,
         genres: [GenreModel]? = nil,
         url: String? = nil) {
        self.artistName = artistName
        self.releaseDate = releaseDate
        self.copyright = copyright
        self.artworkUrl100 = artworkUrl100
        self.name = name
        self.genres = genres
        self.url = url
    }

}

struct GenreModel: Decodable {
    let name: String?
    let url: String?
    public init (name: String? = nil,
                 url: String? = nil) {
        self.name = name
        self.url = url
    }
}
