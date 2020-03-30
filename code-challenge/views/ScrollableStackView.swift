//
//  ScrollableStackView.swift
//  code-challenge
//
//  Created by Dilip on 3/25/20.
//  Copyright © 2020 Dilip. All rights reserved.
//


import Foundation
import UIKit

public class ScrollableStackView: UIView {
    public var containerStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollableStackView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupScrollableStackView()
    }
    
    private func setupScrollableStackView () {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        containerStackView = UIStackView()
        containerStackView.axis = .vertical
        containerStackView.alignment = .center
        containerStackView.spacing = 10
        containerStackView.distribution = .fill
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerStackView)
        NSLayoutConstraint.activate([
            // Attaching the content's edges to the scroll view's edges
            containerStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            // Satisfying size constraints
            containerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    public func addSubviewForStackView (view: UIView, needsPadding: Bool? = true) {
//        for view in subViews {
            containerStackView.addArrangedSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            if needsPadding ?? true {
                containerStackView.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: containerStackView, attribute: .trailing, multiplier: 1, constant: -16))
                containerStackView.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: containerStackView, attribute: .leading, multiplier: 1, constant: 16))
            } else {
                containerStackView.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: containerStackView, attribute: .trailing, multiplier: 1, constant: 0))
                containerStackView.addConstraint(NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: containerStackView, attribute: .leading, multiplier: 1, constant: 0))
            }
 //       }
    }
}
