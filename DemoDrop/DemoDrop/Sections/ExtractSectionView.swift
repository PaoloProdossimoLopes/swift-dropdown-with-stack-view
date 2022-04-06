//
//  ExtractSectionCollectionView.swift
//  DemoDrop
//
//  Created by Paolo Prodossimo Lopes on 05/04/22.
//

import UIKit

protocol ExtractSectionViewDelegate: AnyObject {
    func sectionViewHandleTapped(_ currentIndexSelected: Int)
}

final class ExtractSectionView: UIScrollView {
    
    var currentSelected: ExtractSections = .current
    weak var customDelegate: ExtractSectionViewDelegate?
    
    var titles: [String]
    
    private lazy var customSegmentControll: CustomSegmentedControl = {
        let stack = CustomSegmentedControl(self, buttonTitle: titles)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.selectorViewColor = .orange
        stack.selectorTextColor = .orange
        
        return stack
    }()
    
    init(
        delegate: ExtractSectionViewDelegate,
        titles: [String] = ["Title 1", "Title 2", "Title 3"]
    ) {
        self.titles = titles
        self.customDelegate = delegate
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(customSegmentControll)
        
        customSegmentControll.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        customSegmentControll.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        customSegmentControll.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        customSegmentControll.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
    }
    
    func setupTitles(titles: [String]) {
        self.titles = titles
        customSegmentControll.setButtonTitles(buttonTitles: titles)
    }
    
    func appendTitles(title: String) {
        self.titles.append(title)
        customSegmentControll.setButtonTitles(buttonTitles: titles)
    }
}

extension ExtractSectionView: ExtractSectionSelectorViewDelegate {
    func sectionViewHandleTapped(_ indexSelected: Int) {
        customDelegate?.sectionViewHandleTapped(indexSelected)
    }
}
