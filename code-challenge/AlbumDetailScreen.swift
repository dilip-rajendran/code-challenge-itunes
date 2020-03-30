//
//  AlbumDetailScreen.swift
//  code-challenge
//
//  Created by Dilip on 3/25/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import Foundation
import UIKit

class AlbumDetailScreen: UIViewController {
    var result: resultsModel? = nil
    let artImageView: UIImageView = NikeImageView(style: .FullImage)
    var viewModel: AlbumDetailScreenViewModel?
    let containerView = ScrollableStackView()
    let genreCollectionView: DynamicHeightCollectionView = {
        let layout = UICollectionViewCenterLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let cv = DynamicHeightCollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        return cv
    }()

    convenience init( model: resultsModel? ) {
          self.init()
        if let result = model {
            self.result = result
            viewModel = AlbumDetailScreenViewModel(model: result)
        }
      }
    fileprivate func setupContainerView() {
        containerView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 50)
        view.addSubview(containerView)
    }
    
    fileprivate func setupArtImage() {
        artImageView.loadImage(imageString: viewModel?.artWork) { [weak self] (image) in
            if let downloadedImage = image, let height = self?.calculateAspectRatio(image: downloadedImage) {
                
                self?.artImageView.image = downloadedImage
                self?.artImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
            }
        }
        containerView.addSubviewForStackView(view: artImageView, needsPadding: false)
    }
    
    fileprivate func setupGenreView() {
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
        
        genreCollectionView.register(GenreCell.self, forCellWithReuseIdentifier: "GenreCell")
    }
    
    fileprivate func setupDetailsLabels() {
        let albumLabel = NikeLabel(style: .AlbumLabel)
        albumLabel.text = viewModel?.albumName
        containerView.addSubviewForStackView(view: albumLabel)
        let artistLabel = NikeLabel(style: .ArtistLabel)
        artistLabel.text = viewModel?.artistName
        containerView.addSubviewForStackView(view: artistLabel)
        let releaseDateLabel = NikeLabel(style: .ReleaseDateLabel)
        releaseDateLabel.text = viewModel?.releaseDate
        containerView.addSubviewForStackView(view: releaseDateLabel)
        let copyrightLabel = NikeLabel(style: .CopyrightLabel)
        copyrightLabel.text = viewModel?.copyright
        containerView.addSubviewForStackView(view: copyrightLabel)
    }
    
    fileprivate func setupAppStoreRedirectionButton() {
        let redirectButton: UIButton = {
            let button = AppStoreButton().getButtonForAppStore(titleString: ConstantIdentifiers.appStoreButtonTitle.rawValue)
            button.addTarget(self, action: #selector(contentTargetAction), for: .touchUpInside)
            return button
        }()
        view.addSubview(redirectButton)
        redirectButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            redirectButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20),
            redirectButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            redirectButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            redirectButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupContainerView()
        setupArtImage()
        setupGenreView()
        containerView.addSubviewForStackView(view: genreCollectionView)
        setupDetailsLabels()
        setupAppStoreRedirectionButton()
    }
    @objc func contentTargetAction(sender :UIButton) {
        redirectToWebView(urlString: viewModel?.url)
    }
}
extension AlbumDetailScreen: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.genreArray?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as? GenreCell else {
            fatalError("Can't dequeue reusable cell")
        }
        cell.genreLabel.text = viewModel?.genreArray?[indexPath.row].name ?? ""
        cell.backgroundColor = .systemBlue
        cell.layer.cornerRadius = 6
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        redirectToWebView(urlString: viewModel?.genreArray?[indexPath.row].url)
    }
    
}

extension AlbumDetailScreen {
    func calculateAspectRatio(image: UIImage) -> CGFloat{
        let aspectRatio =  image.size.height / image.size.width
        let imageHeight = self.view.frame.width*aspectRatio
        return imageHeight
    }
}

extension AlbumDetailScreen {
    func redirectToWebView(urlString: String?) {
        viewModel?.getSafariUrlFromContent(urlString: urlString)    
    }
}
