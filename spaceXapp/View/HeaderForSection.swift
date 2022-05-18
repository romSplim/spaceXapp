//
//  HeaderForSection.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 16.05.2022.
//

import UIKit

class HeaderForSection: UIView {
    var textForLabel: String
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 32, y: 5, width: 200, height: 20))
        label.textAlignment = .natural
        label.textColor = .myColor
        label.text = textForLabel
        label.font = UIFont(name: "LabGrotesque-Bold", size: 16)
        return label
    }()
    
    init(withTitle title: String) {
        self.textForLabel = title
        super.init(frame: .zero)
        backgroundColor = .black
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

