//
//  AlbumResuableCellViewModel.swift
//  code-challenge
//
//  Created by Dilip on 3/25/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import Foundation
import UIKit

struct AlbumResuableCellViewModel {
    
    let model: resultsModel?
    var albumName: String? = nil
    var artistName: String? = nil
    var artThumbnailImageURL: String? = nil
    var showAlbumName: Bool = false
    var showArtistName: Bool = false
    var showArtThumbnailImageURL: Bool = false

    init(model: resultsModel? = nil) {
        self.model = model
        albumName = getAlbumName()
        artistName = getArtistName()
        artThumbnailImageURL = getArtThumbnailImageURL()
        showAlbumName =  checkForEmptyStringValue(string: albumName)
        showArtistName = checkForEmptyStringValue(string: artistName)
        showArtThumbnailImageURL = checkForEmptyStringValue(string: artThumbnailImageURL)
    }
    
    func getAlbumName() -> String? {
        if let name = model?.name, name.count > 0 {
            return name
        }
        return nil
    }
    
    func getArtistName() -> String? {
        if let name = model?.artistName, name.count > 0 {
            return name
        }
        return nil
    }
    
    func getArtThumbnailImageURL() -> String? {
        if let imageString = model?.artworkUrl100, imageString.count > 0 {
            return imageString
        }
        return nil
    }
    
    func checkForEmptyStringValue(string:String?) -> Bool{
        guard let instanceString = string, instanceString.count > 0 else {return false}
        return true
    }
}
