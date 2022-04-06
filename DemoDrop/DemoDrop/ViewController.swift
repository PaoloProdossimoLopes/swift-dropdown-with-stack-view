//
//  ViewController.swift
//  DemoDrop
//
//  Created by Paolo Prodossimo Lopes on 04/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var box: ExtractHeaderBoxView = .init(
        viewDatas: [
            HeaderBoxSectionViewData(),
            LimitBoxSectionViewData(),
            LimitBoxSectionViewData()
        ]
    )
    
    private lazy var second: ExtractSectionView = {
        let seg = ExtractSectionView(delegate: self)
        seg.setupTitles(titles: ExtractSections.allCases.map({ $0.sectionName }))
        return seg
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(box)
        box.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        box.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        box.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        view.addSubview(second)
        second.topAnchor.constraint(equalTo: box.bottomAnchor).isActive = true
        second.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        second.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}

extension ViewController: ExtractSectionViewDelegate {
    func sectionViewHandleTapped(_ currentIndexSelected: Int) {
        
    }
}
