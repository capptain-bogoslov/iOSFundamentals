//
//  MovieView.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 7/2/24.
//

import Foundation
import UIKit

class MovieView: UIView {
    
    private lazy var containerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout() {
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24),
        ])
    }
    
}
