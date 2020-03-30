//
//  HomeCell.swift
//  code-challenge
//
//  Created by Dilip on 3/25/20.
//  Copyright © 2020 Dilip. All rights reserved.
//
import UIKit

class GenreCell: UICollectionViewCell {
    static let identifier = "GenreCell"
    
    let genreLabel: UILabel = NikeLabel(style: .GenreLabel)
    var maxWidth: CGFloat? = nil {
        didSet {
            guard let maxWidth = maxWidth else { return }
            genreLabel.widthAnchor.constraint(equalToConstant: maxWidth).isActive = true
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}

private extension GenreCell {
    private func setupViews() {
        addSubview(genreLabel)
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            genreLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            genreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            genreLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6)
        ])
    }
    
}
