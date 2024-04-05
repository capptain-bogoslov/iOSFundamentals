//
//  MovieView.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 7/2/24.
//

import Foundation
import UIKit

class MovieView: UIView {
    
    private lazy var movieImage: UIImageView = {
       let view = UIImageView()
        view.image = UIImage(named: "demoImage")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    //add gradient to image
    private lazy var gradientLayer: CAGradientLayer = {
       let layer = CAGradientLayer()

        layer.colors = [UIColor.black.withAlphaComponent(0.0).cgColor,
                        UIColor.black.withAlphaComponent(0.2).cgColor,
            UIColor.black.withAlphaComponent(0.7).cgColor,
                        UIColor.black.withAlphaComponent(1.0).cgColor]
        layer.locations = [0.0, 0.5, 0.7, 1.0]
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)

        return layer
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Avengers the Light Warrior"
        return label
    }()
    
    var service: NetworkServiceProtocol? = nil
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = movieImage.bounds
        movieImage.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setUpLayout() {
        addSubview(movieImage)
        movieImage.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            movieImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
            movieImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -24),
            movieImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            movieImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -24),
            movieImage.heightAnchor.constraint(equalToConstant: 200),
            titleLabel.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: -32),
            titleLabel.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: movieImage.leadingAnchor, constant: 16),
        ])
    }
    
    func config(title: String, imageString: String, service: NetworkServiceProtocol? = nil) {
        self.titleLabel.text = title

        guard let service = service else { return }
        Task {
            do {
                guard let url = URL(string: MoviesURL.image(name: imageString).url) else { return }
                let imageData = try await service.getImage(from: url)
                self.movieImage.image = UIImage(data: imageData)
                
            } catch {
                print("Error: \(error) fetching image")
            }
        }
    }
}
