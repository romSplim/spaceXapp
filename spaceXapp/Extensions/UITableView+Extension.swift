//
//  UIViewController+Extension.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 16.05.2022.
//

import UIKit

extension UITableView {
    func registerCells(nibName: [String]) {
        nibName.forEach { self.register(UINib(nibName: $0, bundle: nil), forCellReuseIdentifier: $0)}
    }
}
