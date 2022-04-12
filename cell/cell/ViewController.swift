//
//  ViewController.swift
//  cell
//
//  Created by Paolo Prodossimo Lopes on 11/04/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let stack = UIStackView()
//        stack.axis = .vertical
//        stack.spacing = 5
//        stack.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(stack)
//        stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//        stack.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        stack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//
//
//
//
//
//
//
//        var errorViewData = ExtractAlertSectionViewData(
//            rightImageName: "exclamationmark.triangle", leftImageName: "",
//            description: "Sistema indisponivel", backgroundColor: .purple
//        )
//        errorViewData.leftImageTapAction = { print("Left") }
//        errorViewData.cellTapAction = { print("Cell") }
//        errorViewData.rightImageTapAction = { print("Right") }
//        let errorCell = ExtractAlertSectionViewCell()
//        errorCell.setup(viewData: errorViewData)
//        stack.addArrangedSubview(errorCell)
//
//
//        var negativeBalanceViewData = ExtractAlertSectionViewData(
//            rightImageName: "", leftImageName: "xmark",
//            description: "Seu saldo esta negativo", backgroundColor: .red
//        )
//        negativeBalanceViewData.leftImageTapAction = { print("Top") }
//        let negativeCell = ExtractAlertSectionViewCell()
//        negativeCell.setup(viewData: negativeBalanceViewData)
//        stack.addArrangedSubview(negativeCell)
        
        
        
//        DinamicAlertView.shared.show()
//        self.showToast(from: view)
        DinamicAlertView.showToast(from: view)
    }
}




extension UIViewController {
    
    func showToast(from view: UIView) {
        
        let safeAreaY = view.safeAreaInsets.top
        let scaping: CGFloat = (36/2)
        let centerView = view.frame.origin.x
        let safeAreaX = centerView + scaping
        let widthView = view.frame.width - 36
        let viewHeight: CGFloat = 40
        
        let toastLabel = DinamicAlertView(frame: .zero)
        toastLabel.frame.size.width = widthView
        toastLabel.frame.origin.y = safeAreaY
        toastLabel.frame.origin.x = safeAreaX
        
        
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: {
            toastLabel.frame.origin.y += (viewHeight) + 5
        })
    }
}
