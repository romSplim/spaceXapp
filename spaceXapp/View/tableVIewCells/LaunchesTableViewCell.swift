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
    
    let rocketSuccessImg = UIImage(named: "rocketSuccess")
    let rocketFailImg = UIImage(named: "rocketFail")
    let checkmarkSuccessImg = UIImage(systemName: "checkmark.circle.fill")
    let checkmarkFailImg = UIImage(systemName: "xmark.circle.fill")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myView.backgroundColor = .myBackgroundGray
        myView.layer.cornerRadius = 24
        contentView.backgroundColor = .black
        launchNameLbl.font = UIFont(name: "LabGrotesque-Regular", size: 20)
        launchNameLbl.textColor = .white
        launchDateLbl.textColor = .myLightGray
        launchDateLbl.font = UIFont(name: "LabGrotesque-Regular", size: 16)
    }
    
    func getLaunchStatus(model: Launch) {
        if model.success! {
            launchStatus.image = rocketSuccessImg?.withTintColor(.myLightGray)
            checkmarkImg.image = checkmarkSuccessImg?.withTintColor(.green, renderingMode: .alwaysOriginal)
        } else {
            launchStatus.image = rocketFailImg?.withTintColor(.myLightGray)
            checkmarkImg.image = checkmarkFailImg?.withTintColor(.red, renderingMode: .alwaysOriginal)
        }
    }
}
