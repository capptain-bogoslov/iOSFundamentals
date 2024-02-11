//
//  UIViewExtension.swift
//  MovieFlix
//
//  Created by Batsioulas, Theologos on 8/2/24.
//

import Foundation
import UIKit


extension UIView {
    
    func startSkeletonLoading() {
        if self.bounds.isEmpty {
            self.layoutIfNeeded()
        }
        guard !self.bounds.isEmpty && self.layer.mask == nil else {
            addAnimation()
            return }
        let width = bounds.width
        let height = bounds.height
        
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        let gradientColorOne = UIColor.white.withAlphaComponent(0.5).cgColor
        let gradientColorTwo = UIColor.white.withAlphaComponent(0.8).cgColor
        gradient.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        gradient.locations = [0.0, 0.5, 1.0]
        gradient.frame = CGRect(x: -width, y: 0, width: width*3, height: height)
        layer.mask = gradient
        
        addAnimation()
    }
    
    private func addAnimation() {
        guard let gradient = layer.mask else { return }
        let animation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.locations))
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 1.25
        gradient.add(animation, forKey: "placeholderAnimation")
    }
    
    func stopSkeletonLoading() {
        layer.mask = nil
    }
}
