//
//  RocketLaunchesTableViewCell.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 03.04.2022.
//

import UIKit

class ButtonLaunchesTableViewCell: UITableViewCell {

    @IBOutlet weak var showLauchesButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        showLauchesButton.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1)
        showLauchesButton.layer.cornerRadius = self.bounds.height / 6
        showLauchesButton.setTitle("Посмотреть запуски", for: .normal)
        showLauchesButton.titleLabel?.font = UIFont(name: "LabGrotesque-Bold", size: 18)
        showLauchesButton.tintColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        
        contentView.backgroundColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
