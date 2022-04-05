//
//  HeaderBoxSectionView.swift
//  DemoDrop
//
//  Created by Paolo Prodossimo Lopes on 04/04/22.
//

import UIKit

protocol HeaderBoxSectionViewDelegate: AnyObject {
    func extractHeaderActionHandler(_ sender: HeaderBoxSectionViewProtocol)
}

protocol HeaderBoxSectionViewProtocol {
    func changeDropIndicator(isColapsed: Bool)
}

final class HeaderBoxSectionView: UILabel, HeaderBoxSectionViewProtocol {
    
    private weak var deleagte: HeaderBoxSectionViewDelegate?
    
    lazy var icon = UIImageView()
    
    init(_ delegate: HeaderBoxSectionViewDelegate) {
        self.deleagte = delegate
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .blue
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let tap = UITapGestureRecognizer(
            target: self, action: #selector(extractHeaderActionHandler)
        )
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
        
        let circular = UIView()
        circular.translatesAutoresizingMaskIntoConstraints = false
        circular.becameViewToCircularShape(size: 40)
        circular.backgroundColor = .red
        addSubview(circular)
        circular.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        circular.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
//        let icon = UIButton()
        icon.image = .init(systemName: "chevron.down")
        icon.contentMode = .scaleAspectFit
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.heightAnchor.constraint(equalToConstant: 32).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 32).isActive = true
        addSubview(icon)
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        icon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    func setup(viewData: HeaderBoxSectionViewData) {
        text = viewData.title
    }
    
    func changeDropIndicator(isColapsed: Bool) {
        let name = isColapsed ? "chevron.down" : "chevron.up"
        let iconImage = UIImage(systemName: name)
        self.icon.image = iconImage
    }
    
    @objc private func extractHeaderActionHandler() {
        deleagte?.extractHeaderActionHandler(self)
    }
}
