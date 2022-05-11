//
//  TitleTableViewCell.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 02.04.2022.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var rocketNameLbl: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    let myTintColor = UIColor(red: 0.79, green: 0.79, blue: 0.79, alpha: 1)

    override func awakeFromNib() {
        super.awakeFromNib()
        
        settingsButton.setImage(UIImage(named: "gearIcon")?.withTintColor(myTintColor), for: .normal)
        rocketNameLbl.font = UIFont(name: "LabGrotesque-Medium", size: 24)
        selectionStyle = .none
        rocketNameLbl.textColor = .white
        clipsToBounds = true
        backgroundColor = .black
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fetchCellWithData(model: RocketElement, indexPath: IndexPath) {
        rocketNameLbl.text = model.name
    }
}
