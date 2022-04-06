//
//  CustomSegmentedControl.swift
//  DemoDrop
//
//  Created by Paolo Prodossimo Lopes on 06/04/22.
//

import UIKit

protocol ExtractSectionSelectorViewDelegate: AnyObject {
    func sectionViewHandleTapped(_ indexSelected: Int)
}

class CustomSegmentedControl: UIView {
    
    private var buttonTitles: [String] = []
    private var buttons: [UIButton] = []
    private var selectorView: UIView = .init()
    
    var textColor:UIColor = .lightGray
    var selectorViewColor: UIColor = .red
    var selectorTextColor: UIColor = .red
    var textFont: UIFont = .boldSystemFont(ofSize: 14)
    var textSelectedFont: UIFont = .boldSystemFont(ofSize: 14)
    
    weak var delegate: ExtractSectionSelectorViewDelegate?
    
    public private(set) var selectedIndex : Int = 0
    
    convenience init(
        _ delegate: ExtractSectionSelectorViewDelegate? = nil, buttonTitle: [String]
    ) {
        self.init(frame: .zero)
        self.buttonTitles = buttonTitle
        self.setButtonTitles(buttonTitles: buttonTitles)
        self.delegate = delegate
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = UIColor.white
        updateView()
    }
    
    func setButtonTitles(buttonTitles:[String]) {
        self.buttonTitles = buttonTitles
        self.updateView()
    }
    
//    func setIndex(index:Int) {
//        buttons.forEach({
//            $0.setTitleColor(textColor, for: .normal)
//            $0.titleLabel?.font = textFont
//        })
//
//        selectedIndex = index
//
//        let button = buttons[index]
//        button.setTitleColor(selectorTextColor, for: .normal)
//        button.titleLabel?.font = textSelectedFont
//
//        let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(index)
//        UIView.animate(withDuration: 0.2) {
//            self.selectorView.frame.origin.x = selectorPosition
//        }
//    }
    
    @objc private func buttonAction(sender: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            
            btn.setTitleColor(textColor, for: .normal)
            btn.titleLabel?.font = textFont
            
            if btn == sender {
                
                selectedIndex = buttonIndex
                delegate?.sectionViewHandleTapped(selectedIndex)
                
                btn.setTitleColor(self.selectorTextColor, for: .normal)
                btn.titleLabel?.font = self.textSelectedFont
                
                //let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3) {
//                    self.selectorView.frame.origin.x = btn.frame.origin.x
                    self.selectorView.frame = .init(
                        x: btn.frame.origin.x, y: btn.frame.maxY,
                        width: btn.frame.width, height: 2
                    )
                }
            }
        }
    }
}

//Configuration View
extension CustomSegmentedControl {
    private func updateView() {
        createButton()
        configSelectorView()
        configStackView()
    }
    
    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 5
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    private func configSelectorView() {
        let selectorWidth = (frame.width / CGFloat(buttonTitles.count))
        selectorView = UIView(frame: CGRect(x: 0, y: frame.height, width: selectorWidth, height: 2))
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }
    
    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({ $0.removeFromSuperview() })
        for (index, buttonTitle) in buttonTitles.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action:#selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            button.titleLabel?.font = (selectedIndex == index) ? textSelectedFont : textFont
            buttons.append(button)
        }
        
        buttons.first?.setTitleColor(selectorTextColor, for: .normal)
    }
}
