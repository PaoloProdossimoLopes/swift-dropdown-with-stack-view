//
//  ExtractHeaderBoxViewV2.swift
//  DemoDrop
//
//  Created by Paolo Prodossimo Lopes on 04/04/22.
//

import UIKit

final class ExtractHeaderBoxView : UIView {
    
    private(set) var state: BoxState = .colapsed
    var isColapsed: Bool { state == .colapsed }
    
    private(set) var bodyViews: [UIView] = []
    private(set) var viewDatas: [BoxSectionViewDataProtocol]
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - Constructor
    init(viewDatas: [BoxSectionViewDataProtocol] = []) {
        self.viewDatas = viewDatas
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    private func commonInit() {
        configureHierarcy()
        configureConstraints()
        configureStyle()
    }
    
    private func configureHierarcy() {
        addSubview(mainStackView)
        
        generateSubviews()
        inputgeneratedSubviewsInsideStack()
    }
    
    private func configureConstraints() {
        mainStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor).isActive = true
    }
    
    private func configureStyle() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func startActionHandlerWithAnimation () {
        changeState()
        for position in 1..<bodyViews.count {
            UIView.animate(withDuration: 0.25, delay: 0, options: .layoutSubviews) {
                self.changeApearanceDepdendsWithState(at: position)
            } completion: { _ in
                self.updateStateOnCompleted(at: position)
            }
        }
    }
    
    private func updateStateOnCompleted(at: Int) {
        changeAndInputTexts(at: at)
        updateComponentView(at: at)
    }
    
    private func generateSubviews() {
        viewDatas.forEach { item in
            switch item.type {
            case .header:
                let header = makeHeaderSection(viewData: item)
                bodyViews.append(header)
            case .limit:
                let limit = makeLimitSection(viewData: item)
                bodyViews.append(limit)
            case .openBanking:
                return
            case .error:
                <#code#>
            }
        }
    }
    
    private func inputgeneratedSubviewsInsideStack() {
        bodyViews.forEach(mainStackView.addArrangedSubview)
    }
    
    private func makeHeaderSection(viewData: BoxSectionViewDataProtocol) -> UIView {
        let header = HeaderBoxSectionView(self)
        if let viewData = viewData as? HeaderBoxSectionViewData {
            header.setup(viewData: viewData)
        }
        return header
    }
    
    private func makeLimitSection(viewData: BoxSectionViewDataProtocol) -> UIView {
        let limit = LimitBoxSectionView()
        if let viewData = viewData as? LimitBoxSectionViewData {
            limit.setup(viewData: viewData)
        }
        return limit
    }
    
    private func updateComponentView(at: Int) {
        bodyViews[at].layoutIfNeeded()
    }
    
    private func changeAndInputTexts(at: Int) {
        
        if let item = bodyViews[at] as? HeaderBoxSectionView {
            guard let section = (viewDatas[at] as? HeaderBoxSectionViewData) else { return }
            let title = section.title
            //let subtitle = section.title
            item.text = isColapsed ? .empty : title
        }
        
        if let item = bodyViews[at] as? LimitBoxSectionView {
            guard let section = (viewDatas[at] as? LimitBoxSectionViewData) else { return }
            let title = section.title
            //let subtitle = section.title
            item.update(isColapsed: isColapsed)
            item.text = isColapsed ? .empty : title
        }
        
        
    }
    
    private func changeState() {
        state = isColapsed ? .expanded : .colapsed
    }
    
    private func changeApearanceDepdendsWithState(at: Int) {
        let item = bodyViews[at]
        item.isHidden = isColapsed
        item.alpha = isColapsed ? .invisible : .visible
    }
    
    enum BoxState { case expanded, colapsed }
    enum BoxSectionType { case header, limit, openBanking, error }
}

//MARK: - HeaderBoxSectionViewDelegate
extension ExtractHeaderBoxView: HeaderBoxSectionViewDelegate {
    func extractHeaderActionHandler(_ sender: HeaderBoxSectionViewProtocol) {
        startActionHandlerWithAnimation()
        sender.changeDropIndicator(isColapsed: self.isColapsed)
    }
}
