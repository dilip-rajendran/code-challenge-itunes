//
//  Constants.swift
//  code-challenge
//
//  Created by Dilip on 3/25/20.
//  Copyright © 2020 Dilip. All rights reserved.
//
import Foundation

public enum ConstantNumber: Int {
    case noOfRows = 0
}

public enum ConstantIdentifiers: String {
    case appleRSSFeedUrl = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"
    case albumCellIdentifier = "AlbumCell"
    case albumPlaceholder = "Album: "
    case artistPlaceholder = "Artist: "
    case releaseDatePlaceholder = "Release Date: "
    case appStoreButtonTitle = "Go to App Store"
}
