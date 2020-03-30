//
//  AlbumResuableTableViewCell.swift
//  code-challenge
//
//  Created by Dilip on 3/24/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import UIKit

class AlbumResuableCell: UITableViewCell {
    static let identifier = ConstantIdentifiers.albumCellIdentifier.rawValue
    let albumLabel = NikeLabel(style: .AlbumLabel)
    let artistLabel = NikeLabel(style: .ArtistLabel)
    let artThumbnail: UIImageView = NikeImageView(style: .Thumbnail)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }

}
extension AlbumResuableCell {
    func bindViewModel(viewModel: AlbumResuableCellViewModel) {
        albumLabel.isHidden = viewModel.showAlbumName ? false :  true
        artistLabel.isHidden = viewModel.showArtistName ? false : true
        artThumbnail.isHidden = viewModel.showArtThumbnailImageURL ? false : true
        if (!albumLabel.isHidden) { albumLabel.text = viewModel.albumName }
        if (!artistLabel.isHidden) { artistLabel.text = viewModel.artistName }
        if (!artThumbnail.isHidden) {
            artThumbnail.loadImage(imageString: viewModel.artThumbnailImageURL) {  [weak self] (image) in
               if let downloadedImage = image{
                    self?.artThumbnail.image = downloadedImage
                }
            }
        }

    }
}
extension AlbumResuableCell {
    private func setupViews() {
        let stackview = UIStackView()
        addSubview(stackview)
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.spacing = 10
        NSLayoutConstraint.activate([
        // Attaching the content's edges to the scroll view's edges
            stackview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        stackview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        stackview.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        stackview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        // Satisfying size constraints
        ])

        stackview.addArrangedSubview(artThumbnail)
        stackview.addArrangedSubview(setupLabelComponents())
    }
    private func setupLabelComponents() -> UIStackView{
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.spacing = 10
        stackview.distribution = .fill
        stackview.addArrangedSubview(albumLabel)
        stackview.addArrangedSubview(artistLabel)
        return stackview
    }
}

