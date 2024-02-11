//
//  SkeletonCell.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 8/2/24.
//

import Foundation
import UIKit


class SkeletonCell: UIView {
    
    private lazy var imagePlaceholder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "LightGray")
        view.layer.opacity = 0.8
        return view
    }()
    
    private lazy var titlePlaceholder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "MediumGray")
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        view.layer.opacity = 0.8
        return view
    }()
    
    private lazy var ratingPlaceholder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "MediumGray")
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        view.layer.opacity = 0.8
        return view
    }()
    
    private lazy var datePlaceholder: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "MediumGray")
        view.layer.opacity = 0.8
        return view
    }()
    
    private lazy var favouritePlaceholder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "MediumGray")
        view.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        view.layer.opacity = 0.8
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imagePlaceholder.startSkeletonLoading()
        titlePlaceholder.startSkeletonLoading()
        ratingPlaceholder.startSkeletonLoading()
        datePlaceholder.startSkeletonLoading()
        favouritePlaceholder.startSkeletonLoading()
    }
    
    func setUpLayout() {
        addSubview(imagePlaceholder)
        imagePlaceholder.addSubview(titlePlaceholder)
        imagePlaceholder.addSubview(ratingPlaceholder)
        imagePlaceholder.addSubview(datePlaceholder)
        imagePlaceholder.addSubview(favouritePlaceholder)

        
        NSLayoutConstraint.activate([
            imagePlaceholder.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            imagePlaceholder.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            imagePlaceholder.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            imagePlaceholder.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24),
            imagePlaceholder.heightAnchor.constraint(equalToConstant: 200),
            titlePlaceholder.bottomAnchor.constraint(equalTo: ratingPlaceholder.topAnchor, constant: -10),
            titlePlaceholder.leadingAnchor.constraint(equalTo: imagePlaceholder.leadingAnchor, constant: 16),
            titlePlaceholder.widthAnchor.constraint(equalToConstant: 250),
            titlePlaceholder.heightAnchor.constraint(equalToConstant: 30),
            ratingPlaceholder.bottomAnchor.constraint(equalTo: imagePlaceholder.bottomAnchor, constant: -16),
            ratingPlaceholder.leadingAnchor.constraint(equalTo: imagePlaceholder.leadingAnchor, constant: 16),
            ratingPlaceholder.widthAnchor.constraint(equalToConstant: 100),
            ratingPlaceholder.heightAnchor.constraint(equalToConstant: 25),
            datePlaceholder.leadingAnchor.constraint(equalTo: ratingPlaceholder.trailingAnchor, constant: 8),
            datePlaceholder.bottomAnchor.constraint(equalTo: imagePlaceholder.bottomAnchor, constant: -16),
            datePlaceholder.widthAnchor.constraint(equalToConstant: 80),
            datePlaceholder.heightAnchor.constraint(equalToConstant: 25),
            favouritePlaceholder.trailingAnchor.constraint(equalTo: imagePlaceholder.trailingAnchor, constant: -16),
            favouritePlaceholder.bottomAnchor.constraint(equalTo: imagePlaceholder.bottomAnchor, constant: -16),
            favouritePlaceholder.widthAnchor.constraint(equalToConstant: 30),
            favouritePlaceholder.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func stopAnimations() {
        self.imagePlaceholder.stopSkeletonLoading()
        self.titlePlaceholder.stopSkeletonLoading()
        self.ratingPlaceholder.stopSkeletonLoading()
        self.datePlaceholder.stopSkeletonLoading()
        self.favouritePlaceholder.stopSkeletonLoading()
    }
}
