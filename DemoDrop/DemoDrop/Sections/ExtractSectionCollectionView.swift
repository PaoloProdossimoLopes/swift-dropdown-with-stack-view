//
//  ExtractSectionCollectionView.swift
//  DemoDrop
//
//  Created by Paolo Prodossimo Lopes on 05/04/22.
//

import UIKit

protocol ExtractSectionViewDelegate: AnyObject {
    func sectionViewHandleTapped(_ sender: ExtractSectionSelectorView)
}

final class ExtractSectionView: UIScrollView {
    
    enum ExtractSections: CaseIterable {
        case tudo
        case futuro
        case demonstrativos
        case encargos
        
        var sectionName: String {
            (self == .tudo) ? String(describing: self) : ""
        }
    }
    
    var currentSelected: ExtractSections = .tudo
    weak var customDelegate: ExtractSectionViewDelegate?
    
    private lazy var mainHStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = stack.bounds
        gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.red.cgColor]
        gradientLayer.locations = [0, 1]
        stack.layer.insertSublayer(gradientLayer, at: 0)
        
        return stack
    }()
    
    private lazy var listOfSections: [ExtractSectionSelectorView] = {
        var itens = [ExtractSectionSelectorView]()
        for section in ExtractSections.allCases {
            let view = ExtractSectionSelectorView(delegate: self, section: section)
            itens.append(view)
        }
        return itens
    }()
    
    init(delegate: ExtractSectionViewDelegate) {
        self.customDelegate = delegate
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        listOfSections.forEach(mainHStackView.addArrangedSubview)
        
        addSubview(mainHStackView)
        mainHStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        mainHStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainHStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: mainHStackView.bottomAnchor, constant: 5).isActive = true
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let view = UIView()
        view.backgroundColor = .clear
        view.frame = frame
        addSubview(view)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = .init(x: 0, y: 0, width: 430, height: 60)
        gradientLayer.colors = [
            UIColor.white.withAlphaComponent(0).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor,
            UIColor.white.cgColor
        ]
        gradientLayer.locations = [0.0, 0.7, 1.0]
        gradientLayer.startPoint = .zero
        gradientLayer.endPoint = .init(x: 1, y: 0)
        view.layer.addSublayer(gradientLayer)
        
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
    }
}

extension ExtractSectionView: ExtractSectionSelectorViewDelegate {
    func sectionViewHandleTapped(_ sender: ExtractSectionSelectorView) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .beginFromCurrentState) {
            self.listOfSections.first(where: { $0.section == self.currentSelected })?.deselectAsCurrent()
            sender.selectedAsCurrent()
        } completion: { _ in
            self.currentSelected = sender.section
            self.customDelegate?.sectionViewHandleTapped(sender)
        }
    }
}






protocol ExtractSectionSelectorViewDelegate: AnyObject {
    func sectionViewHandleTapped(_ sender: ExtractSectionSelectorView)
}

final class ExtractSectionSelectorView: UIView {
    
    let section: ExtractSectionView.ExtractSections
    weak var delegate: ExtractSectionSelectorViewDelegate?
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = section.sectionName
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var bottomIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(delegate: ExtractSectionSelectorViewDelegate, section: ExtractSectionView.ExtractSections) {
        self.section = section
        self.delegate = delegate
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(titleLabel)
        addSubview(bottomIndicatorView)
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        bottomIndicatorView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        bottomIndicatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bottomIndicatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomIndicatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        bottomAnchor.constraint(equalTo: bottomIndicatorView.bottomAnchor).isActive = true
        
        bottomIndicatorView.backgroundColor = (section == .tudo) ? .orange : .white
        bottomIndicatorView.isHidden = !(section == .tudo)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(sectionViewHandleTapped))
        addGestureRecognizer(tap)
        //isUserInteractionEnabled = true
        isUserInteractionEnabled = (section.sectionName.isEmpty == false)
    }
    
    func selectedAsCurrent() {
        bottomIndicatorView.backgroundColor = .orange
        bottomIndicatorView.isHidden = false
    }
    
    func deselectAsCurrent() {
        bottomIndicatorView.backgroundColor = .white
        bottomIndicatorView.isHidden = true
    }
    
    @objc private func sectionViewHandleTapped() {
        delegate?.sectionViewHandleTapped(self)
    }
}



extension CAGradientLayer {
    enum Point {
        case topLeft
        case centerLeft
        case bottomLeft
        case topCenter
        case center
        case bottomCenter
        case topRight
        case centerRight
        case bottomRight
        var point: CGPoint {
            switch self {
            case .topLeft:
                return CGPoint(x: 0, y: 0)
            case .centerLeft:
                return CGPoint(x: 0, y: 0.5)
            case .bottomLeft:
                return CGPoint(x: 0, y: 1.0)
            case .topCenter:
                return CGPoint(x: 0.5, y: 0)
            case .center:
                return CGPoint(x: 0.5, y: 0.5)
            case .bottomCenter:
                return CGPoint(x: 0.5, y: 1.0)
            case .topRight:
                return CGPoint(x: 1.0, y: 0.0)
            case .centerRight:
                return CGPoint(x: 1.0, y: 0.5)
            case .bottomRight:
                return CGPoint(x: 1.0, y: 1.0)
            }
        }
    }
    convenience init(start: Point, end: Point, colors: [CGColor], type: CAGradientLayerType) {
        self.init()
        self.startPoint = start.point
        self.endPoint = end.point
        self.colors = colors
        self.locations = (0..<colors.count).map(NSNumber.init)
        self.type = type
    }
}
