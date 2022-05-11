//
//  CollectionViewInCell.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 03.04.2022.
//

import UIKit

class CollectionViewInCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "RoundedRectCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RoundedRectCollectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        contentView.backgroundColor = .black
        collectionView.backgroundColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
