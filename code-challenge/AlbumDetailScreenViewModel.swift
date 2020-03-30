//
//  AlbumDetailScreenViewModel.swift
//  code-challenge
//
//  Created by Dilip on 3/26/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
struct AlbumDetailScreenViewModel {
    var artWork: String? = nil
    var genreArray: [GenreModel]? = nil
    var albumName: String? = nil
    var artistName: String? = nil
    var releaseDate: String? = nil
    var copyright: String? = nil
    var url: String? = nil

    var model: resultsModel?
     init(model: resultsModel) {
        self.model = model
        artWork = getArtWork()
        genreArray = getGenreArray()
        albumName = getAlbumName()
        artistName = getArtistName()
        releaseDate = getReleaseDate()
        copyright = getCopyright()
        url = getURL()
    }
    func getURL() -> String? {
        if let url = model?.url {
            return url
        }
        return nil
    }
    func getArtWork() -> String?{
        if let artWork = model?.artworkUrl100 {
            return artWork
        }
        return nil
    }
    func getGenreArray() -> [GenreModel]?{
        if let artWork = model?.genres {
            return artWork
        }
        return nil
    }
    func getAlbumName() -> String?{
        if let artWork = model?.name {
            return ConstantIdentifiers.albumPlaceholder.rawValue + artWork
        }
        return nil
    }
    func getArtistName() -> String?{
        if let artWork = model?.artistName {
            return ConstantIdentifiers.artistPlaceholder.rawValue + artWork
        }
        return nil
    }
    func getReleaseDate() -> String?{
        if let artWork = model?.releaseDate {
            return ConstantIdentifiers.releaseDatePlaceholder.rawValue + artWork
        }
        return nil
    }
    func getCopyright() -> String?{
        if let artWork = model?.copyright {
            return artWork
        }
        return nil
    }
    func getSafariUrlFromContent(urlString: String?) -> SFSafariViewController? {
        
        if let stringURL = urlString, let url = URL(string: stringURL) {
            let config = SFSafariViewController.Configuration()
            return SFSafariViewController(url: url, configuration: config)
        }
        return nil
    }
}
