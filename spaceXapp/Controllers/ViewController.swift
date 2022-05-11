//
//  ViewController.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 01.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    init(data: RocketElement) {
        self.rocketsData = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let dictForUnits = ["m" : 0,
                        "ft" : 1,
                        "kg" : 0,
                        "lb" : 1 ]
    
    var heightUnit = "m"
    var diameterUnit = "m"
    var massUnit = "kg"
    var payloadUnit = "kg"
    
    
    let countries = ["United States" : "США" , "Republic of the Marshall Islands" : "Маршaлловы Островa"]
    let sectionNames = ["Первая ступень","Вторая ступень"]
    
    var rocketsData: RocketElement

    let date = Date()
    
    let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.hidesWhenStopped = true
        indicator.contentMode = .center
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    func registerCells(nibName: [String]) {
        nibName.forEach { tableView.register(UINib(nibName: $0, bundle: nil), forCellReuseIdentifier: $0)}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells(nibName: ["TitleTableViewCell", "CollectionViewInCell", "RocketInfoTableViewCell", "ButtonLaunchesTableViewCell", "TonAndSecTableViewCell"])
        let imageHeader = setupHeader(tableView: tableView)
        getRocketImages(header: imageHeader)
        setupConstraints()
    }
    
    func setupConstraints() {
        view.addSubview(tableView)
        view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupHeader(tableView: UITableView) -> StretchyHeader {
        let header = StretchyHeader(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width))
        
        tableView.tableHeaderView = header
        return header
    }

    func getRocketImages(header: StretchyHeader) {
        NetworkService.shared.fetchRocketImage(with: rocketsData) { data in
            DispatchQueue.main.async {
                header.imageView.image = UIImage(data: data)
                self.indicator.stopAnimating()
                self.tableView.isHidden = false
            }
        }
    }
    
    @objc func settingsButtonTapped(_ sender: UIButton) {
        let settingsVC = SettingsViewController()
        settingsVC.heightSegment.selectedSegmentIndex = dictForUnits[heightUnit]!
        settingsVC.diameterSegment.selectedSegmentIndex = dictForUnits[diameterUnit]!
        settingsVC.massSegment.selectedSegmentIndex = dictForUnits[massUnit]!
        settingsVC.payloadSegment.selectedSegmentIndex = dictForUnits[payloadUnit]!
        
        settingsVC.completion = { height, diameter, mass, payload in
            if let height = height {
                self.heightUnit = height
            }
            if let diameter = diameter {
                self.diameterUnit = diameter
            }
            if let mass = mass {
                self.massUnit = mass
            }
            if let payload = payload {
                self.payloadUnit = payload
            }
            self.tableView.reloadData()
        }
        
        settingsVC.modalPresentationStyle = .popover
        present(UINavigationController(rootViewController: settingsVC), animated: true, completion: nil)
    }
    
    @objc func launchesButtonTapped(sender: UIButton) {
        let launchesVC = LaunchesViewController()
        launchesVC.rocketID = rocketsData.id
        launchesVC.rocketName = rocketsData.name
        navigationController?.pushViewController(launchesVC, animated: true)
    }
    
    func customHeaderView(title: String) -> UIView {
        let view = UIView()
        let label = UILabel(frame: CGRect(x: 32, y: 5, width: 200, height: 20))
        label.textAlignment = .natural
        label.textColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        label.text = title
        label.font = UIFont(name: "LabGrotesque-Bold", size: 16)
        view.backgroundColor = tableView.backgroundColor
        view.addSubview(label)
        return view
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 3 || section == 4 {
            
            return sectionNames[section - 3]
        }
        return ""
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? StretchyHeader else { return }
        header.scrollViewDidScroll(scrollView: tableView)
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


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoundedRectCollectionViewCell", for: indexPath) as? RoundedRectCollectionViewCell else { return UICollectionViewCell()}
        cell.fetchCellWihData(model: rocketsData, units: [heightUnit,diameterUnit,massUnit,payloadUnit] , indexPath: indexPath)
        
        return cell
    }
    
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
