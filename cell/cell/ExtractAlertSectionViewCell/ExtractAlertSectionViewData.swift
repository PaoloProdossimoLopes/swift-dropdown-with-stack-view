//
//  ExtractAlertSectionViewData.swift
//  cell
//
//  Created by Paolo Prodossimo Lopes on 12/04/22.
//

import UIKit

struct ExtractAlertSectionViewData {
    var rightImageName: String = ""
    var leftImageName: String = ""
    var description: String = ""
    var backgroundColor: UIColor = .clear
    var rightImageTapAction: (() -> Void)?
    var leftImageTapAction: (() -> Void)?
    var cellTapAction: (() -> Void)?
}
