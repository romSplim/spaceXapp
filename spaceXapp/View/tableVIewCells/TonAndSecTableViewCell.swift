//
//  TonAndSecTableViewCell.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 19.04.2022.
//

import UIKit

class TonAndSecTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    @IBOutlet weak var unitLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .black
        textLbl.sizeToFit()
        valueLbl.sizeToFit()
        
        textLbl.font = UIFont(name: "LabGrotesque-Regular", size: 16)
        valueLbl.font = UIFont(name: "LabGrotesque-Bold", size: 16)
        unitLbl.font = UIFont(name: "LabGrotesque-Bold", size: 16)
        textLbl.textColor = .myColor2
        valueLbl.textColor = .myColor
        unitLbl.textColor = .myLightGray
    }
    
    func fetchCellWithData(model: RocketElement, indexPath: IndexPath) {
        let textForOtherSection = ["Количество двигателей","Количество топлива","Время сгорания"]

        if indexPath.section == 3 {
            let firstStage = model.firstStage
            let valuesForOtherSections: [Any] = [firstStage.engines, firstStage.fuelAmountTons,firstStage.burnTimeSEC ?? 0]
            textLbl.text = textForOtherSection[indexPath.row]
            valueLbl.text = "\(valuesForOtherSections[indexPath.row])"
            hideUnitsLbl(arr: textForOtherSection)
        } else if indexPath.section == 4 {
            let secondStage = model.secondStage
            let valuesForOtherSections: [Any] = [secondStage.engines, secondStage.fuelAmountTons, secondStage.burnTimeSEC ?? 0]
            textLbl.text = textForOtherSection[indexPath.row]
            valueLbl.text = "\(valuesForOtherSections[indexPath.row])"
            hideUnitsLbl(arr: textForOtherSection)
        }
    }
    
    func hideUnitsLbl(arr: [String]) {
        if textLbl.text == arr[0] {
            unitLbl.text = ""
        } else if textLbl.text == arr[1] {
            unitLbl.text = "ton"
        } else if textLbl.text == arr[2] {
            unitLbl.text = "sec"
        }
    }
}
