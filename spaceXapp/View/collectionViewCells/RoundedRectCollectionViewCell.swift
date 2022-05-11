//
//  RoundedRectCollectionViewCell.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 03.04.2022.
//

import UIKit

class RoundedRectCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myView: UIView!
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)
        myView.layer.cornerRadius = 38
        valueLabel.font = UIFont(name: "LabGrotesque-Bold", size: 16)
        valueLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        textLabel.font = UIFont(name: "LabGrotesque-Regular", size: 14)
        textLabel.textColor = UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1)
        textLabel.sizeToFit()
    }
    
    func fetchCellWihData(model:RocketElement,units: [String] , indexPath: IndexPath) {
        var heightValue: Double?
        var diameterValue: Double?
        var massValue: String?
        var payloadValue: String?
        
        let text = ["Высота,\(units[0])","Диаметр,\(units[1])","Масса,\(units[2])","Нагрузка,\(units[3])"]
        
        if units[0] == "m" {
            heightValue = model.height.meters!
        } else {
            heightValue = model.height.feet!
        }
        if units[1] == "m" {
            diameterValue = model.diameter.meters
        } else {
            diameterValue = model.diameter.feet
        }
        if units[2] == "kg" {
            massValue = model.mass.kg.formattedWithSeparator
        } else {
            massValue = model.mass.lb.formattedWithSeparator
        }
        if units[3] == "kg" {
            payloadValue = model.payloadWeights[0].kg.formattedWithSeparator
        } else {
            payloadValue = model.payloadWeights[0].lb.formattedWithSeparator
        }
        
        let dynamicValues: [Any] = [heightValue ?? 0, diameterValue ?? 0, massValue ?? 0, payloadValue ?? 0]
        textLabel.text = text[indexPath.row]
        valueLabel.text = "\(dynamicValues[indexPath.item])"
    }
}
