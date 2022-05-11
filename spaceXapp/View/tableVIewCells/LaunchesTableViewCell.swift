//
//  LaunchesTableViewCell.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 17.04.2022.
//

import UIKit

class LaunchesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var launchNameLbl: UILabel!
    @IBOutlet weak var launchDateLbl: UILabel!
    @IBOutlet weak var launchStatus: UIImageView!
    @IBOutlet weak var checkmarkImg: UIImageView!
    
    let rocketSuccess = UIImage(named: "rocketSuccess")
    let rocketFail = UIImage(named: "rocketFail")
    let checkmarkSuccess = UIImage(systemName: "checkmark.circle.fill")
    let checkmarkFail = UIImage(systemName: "xmark.circle.fill")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myView.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)
        myView.layer.cornerRadius = 24
        contentView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        launchNameLbl.font = UIFont(name: "LabGrotesque-Regular", size: 20)
        launchNameLbl.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        launchDateLbl.textColor = UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1)
        launchDateLbl.font = UIFont(name: "LabGrotesque-Regular", size: 16)
    }
    
    func getLaunchStatus(model: Launch) {
        if model.success == true {
            launchStatus.image = rocketSuccess?.withTintColor(UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1))
            checkmarkImg.image = checkmarkSuccess?.withTintColor(.green, renderingMode: .alwaysOriginal)
        } else {
            launchStatus.image = rocketFail?.withTintColor(UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1))
            checkmarkImg.image = checkmarkFail?.withTintColor(.red, renderingMode: .alwaysOriginal)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
