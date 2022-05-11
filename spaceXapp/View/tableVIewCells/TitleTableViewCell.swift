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
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = false
        settingsButton.imageView?.tintColor = .systemGray4
        settingsButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        rocketNameLbl.font = .boldSystemFont(ofSize: 22)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
