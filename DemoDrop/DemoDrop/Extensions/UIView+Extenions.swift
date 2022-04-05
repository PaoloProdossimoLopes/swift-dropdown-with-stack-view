//
//  UIView.swift
//  DemoDrop
//
//  Created by Paolo Prodossimo Lopes on 05/04/22.
//

import UIKit

extension UIView {
    func becameViewToCircularShape(size: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: size).isActive = true
        widthAnchor.constraint(equalToConstant: size).isActive = true
        layer.cornerRadius = size/2
        clipsToBounds = true
    }
}
