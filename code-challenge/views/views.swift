//
//  views.swift
//  code-challenge
//
//  Created by Dilip on 3/26/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import Foundation
import UIKit
enum LabelTypes {
    case ArtistLabel
    case AlbumLabel
    case CopyrightLabel
    case ReleaseDateLabel
    case GenreLabel
}
enum ImageType {
    case Thumbnail
    case FullImage
}
class NikeImageView: UIImageView {
    var style: ImageType?
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)!
            self.commonInit()

        }
        convenience init(style: ImageType) {
            self.init(image: nil)
            self.style = style
            self.commonInit()

        }
        override init(frame: CGRect) {
            super.init(frame: frame)
        }
          override init(image: UIImage?) {
                  super.init(image: image)
              }
        func commonInit(){
            self.clipsToBounds = true
            self.translatesAutoresizingMaskIntoConstraints = false
            switch style {
            case .Thumbnail:
                self.contentMode = UIView.ContentMode.scaleAspectFill
                self.layer.cornerRadius = 20
                self.widthAnchor.constraint(equalToConstant: 100).isActive = true
                self.heightAnchor.constraint(equalToConstant: 100).isActive = true

            case .FullImage:
                self.contentMode = UIView.ContentMode.scaleAspectFit
            case .none:
            break
            }
    }


}
class NikeLabel: UILabel {
    var style: LabelTypes?
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()

    }
    convenience init(style: LabelTypes) {
        self.init()
        self.style = style
        self.commonInit()

    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    func commonInit(){
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 0
        switch style {
        case .AlbumLabel:
            self.textColor = .black
            self.font = UIFont(name: "Georgia-Bold", size: 16)
        case .ArtistLabel:
            self.textColor = .darkGray
            self.font = UIFont(name: "Georgia", size: 14)
        case .CopyrightLabel:
            self.textColor = .brown
            self.font = UIFont(name: "Georgia-Italic", size: 10)
        case .ReleaseDateLabel:
            self.textColor = .black
            self.font = UIFont(name: "Georgia", size: 12)
        case .GenreLabel:
            self.textColor = .white
            self.font = UIFont(name: "Georgia", size: 15)
        case .none:
        self.textColor = .black
        }
}
}
class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
struct HeaderView {
    func getHeaderView(titleString: String) -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        let label = UILabel()
        
        label.text = titleString
        label.font = UIFont(name: "Georgia-Bold", size: 30)
        label.textColor = .darkGray
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5)
        ])
        return view
    }
}
struct AppStoreButton {
    func getButtonForAppStore(titleString: String) -> UIButton {
        let button = UIButton()
        button.setTitle("Go to App Store", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 10
        return button
    }
}
