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
        showLauchesButton.backgroundColor = .darkGray
        showLauchesButton.layer.cornerRadius = self.bounds.height / 6
        showLauchesButton.setTitle("Посмотреть запуски", for: .normal)
        showLauchesButton.tintColor = .white
        contentView.backgroundColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
