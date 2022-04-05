//
//  ViewController.swift
//  DemoDrop
//
//  Created by Paolo Prodossimo Lopes on 04/04/22.
//

import UIKit

class ViewController: UIViewController {
    
//    private lazy var box: ExtractHeaderBoxView = {
//        let box: ExtractHeaderBoxView = .init()
//        box.backgroundColor = .red
//        box.translatesAutoresizingMaskIntoConstraints = false
//        return box
//    }()
    
    private lazy var box: ExtractHeaderBoxView = {
        let view: ExtractHeaderBoxView = .init(viewDatas: [
            HeaderBoxSectionViewData(),
            LimitBoxSectionViewData(),
            LimitBoxSectionViewData()
        ])
        return view
    }()
    
    
//    private lazy var second: UIView = {
//        let view = UIView()
//        view.backgroundColor = .systemMint
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    private lazy var second: ExtractSectionView = .init(delegate: self)

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
//        second.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }

}

extension ViewController: ExtractSectionViewDelegate {
    func sectionViewHandleTapped(_ sender: ExtractSectionSelectorView) {
        
    }
}
