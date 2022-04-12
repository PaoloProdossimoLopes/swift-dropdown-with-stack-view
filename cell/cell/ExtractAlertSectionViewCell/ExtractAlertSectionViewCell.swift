//
//  ExtractAlertSectionViewCell.swift
//  cell
//
//  Created by Paolo Prodossimo Lopes on 12/04/22.
//

import UIKit

final class ExtractAlertSectionViewCell: UITableViewCell {
    
    private var viewData: ExtractAlertSectionViewData?
    
    private(set) lazy var alertRightIconView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.circle")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .white
        return iv
    }()
    
    private(set) lazy var alertLeftIconView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = .white
        return iv
    }()
    
    private(set) lazy var alertDescription: UILabel = {
        let label = UILabel()
        label.text = "Sistema indisponivel."
        label.textColor = .white
        return label
    }()
    
    private lazy var mainHStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 20
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .purple
        view.layer.cornerRadius = 5
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(viewData: ExtractAlertSectionViewData) {
        self.viewData = viewData
        
        alertRightIconView.image = UIImage(systemName: viewData.rightImageName)
        alertRightIconView.isHidden = viewData.rightImageName.isEmpty
        
        alertLeftIconView.image = UIImage(systemName: viewData.leftImageName)
        alertLeftIconView.isHidden = viewData.leftImageName.isEmpty
        
        alertDescription.text = viewData.description
        containerView.backgroundColor = viewData.backgroundColor
    }
    
    private func commonInit() {
        configureHierarcy()
        configureConstraints()
        configureStyle()
        configureActions()
    }
    
    private func configureHierarcy() {
        addSubview(containerView)
        containerView.addSubview(mainHStackView)
        mainHStackView.addArrangedSubview(alertRightIconView)
        mainHStackView.addArrangedSubview(alertDescription)
        mainHStackView.addArrangedSubview(alertLeftIconView)
    }
    
    private func configureConstraints() {
        alertRightIconView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        alertRightIconView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        alertLeftIconView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        
        mainHStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
        mainHStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        mainHStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20).isActive = true
        
        containerView.bottomAnchor.constraint(equalTo: mainHStackView.bottomAnchor, constant: 8).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 8).isActive = true
    }
    
    private func configureStyle() {
        backgroundColor = .clear
        contentView.isHidden = true
    }
    
    private func configureActions() {
        let rightImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(rightImageActionTapped))
        let cellContentTapGesture = UITapGestureRecognizer(target: self, action: #selector(cellContentActionTapped))
        let leftImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(leftImageActionTapped))
        
        alertDescription.addGestureRecognizer(cellContentTapGesture)
        alertDescription.isUserInteractionEnabled = true
        
        alertRightIconView.addGestureRecognizer(rightImageTapGesture)
        alertRightIconView.isUserInteractionEnabled = true
        
        alertLeftIconView.addGestureRecognizer(leftImageTapGesture)
        alertLeftIconView.isUserInteractionEnabled = true
    }
    
    @objc private func rightImageActionTapped() {
        viewData?.rightImageTapAction?()
    }
    
    @objc private func leftImageActionTapped() {
        viewData?.leftImageTapAction?()
    }
    
    @objc private func cellContentActionTapped() {
        viewData?.cellTapAction?()
    }
}
