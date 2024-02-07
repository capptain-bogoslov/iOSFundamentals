//
//  MovieSearchTableCell.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 7/2/24.
//

import UIKit

class GeneriTableViewCell<T: UIView>: UITableViewCell {
    
    typealias View = T
    
    lazy var view: View = {
        let view = View()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpLayout() {
        backgroundColor = .clear
        self.contentView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
}
