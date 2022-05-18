//
//  ViewController+Extension.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 16.05.2022.
//

import UIKit
//MARK: - UITableView DataSource methods

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 || section == 5 {
            return 1
        }
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as? TitleTableViewCell else { return UITableViewCell()}
            cell.fetchCellWithData(model: rocketsData, indexPath: indexPath)
            cell.settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
            return cell
            
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionViewInCell", for: indexPath) as? CollectionViewInCell else { return UITableViewCell()}
            cell.collectionView.reloadData()
            return cell
            
        } else if indexPath.section == 2  {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RocketInfoTableViewCell", for: indexPath) as? RocketInfoTableViewCell else { return UITableViewCell()}
            cell.fetchCellWithData(model: rocketsData, countriesDict: countries, indexPath: indexPath)
            return cell
            
        } else if indexPath.section == 3 || indexPath.section == 4 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TonAndSecTableViewCell", for: indexPath) as? TonAndSecTableViewCell else { return UITableViewCell()}
            cell.fetchCellWithData(model: rocketsData, indexPath: indexPath)
            return cell
            
        } else if indexPath.section == 5 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonLaunchesTableViewCell", for: indexPath) as? ButtonLaunchesTableViewCell else { return UITableViewCell()}
            cell.showLauchesButton.addTarget(self, action: #selector(launchesButtonTapped(sender:)), for: .touchUpInside)
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: - UITableView Delegate methods
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 3 || section == 4 {
            
            return sectionNames[section - 3]
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? CollectionViewInCell {
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 3 {
            return customHeaderView(title: "ПЕРВАЯ СТУПЕНЬ")
        } else if section == 4 {
            return customHeaderView(title: "ВТОРАЯ СТУПЕНЬ")
        }
        return nil
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 3 || section == 4 {
            return UITableView.automaticDimension
        } else {
            return 0.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 || section == 3 || section == 4 || section == 1 {
            return 40
        } else {
            return 0.0
        }
    }
}

//MARK: - UICollectionView DataSource methods
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoundedRectCollectionViewCell", for: indexPath) as? RoundedRectCollectionViewCell else { return UICollectionViewCell()}
        cell.fetchCellWihData(model: rocketsData, units: [heightUnit,diameterUnit,massUnit,payloadUnit] , indexPath: indexPath)
        
        return cell
    }
}

//MARK: - UICollectionView DelegateFlowLayout methods
extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 32, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.bounds.width / 3) - 25
        
        return CGSize(width: width, height: width)
    }
}

