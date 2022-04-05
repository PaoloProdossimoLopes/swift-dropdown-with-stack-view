//
//  LimitBoxSectionView.swift
//  DemoDrop
//
//  Created by Paolo Prodossimo Lopes on 04/04/22.
//

import UIKit

final class LimitBoxSectionView: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        text = "Limite disponivel"
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        isHidden = true
        alpha = .invisible
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewData: LimitBoxSectionViewData) {
        text = viewData.title
    }
    
    func update(isColapsed: Bool) {
        isHidden = isColapsed
        alpha = isColapsed ? .invisible : .visible
    }
}
