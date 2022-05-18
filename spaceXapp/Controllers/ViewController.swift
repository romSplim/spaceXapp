//
//  ViewController.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 01.04.2022.
//

import UIKit

class ViewController: UIViewController {
    var rocketsData: RocketElement
    let date = Date()
    let measure = Measure()
    
    var heightUnit = Unit.m.rawValue
    var diameterUnit = Unit.m.rawValue
    var massUnit = Unit.kg.rawValue
    var payloadUnit = Unit.kg.rawValue
    
    let countries = ["United States" : "США" , "Republic of the Marshall Islands" : "Маршaлловы Островa"]
    let sectionNames = ["Первая ступень","Вторая ступень"]
    
    init(data: RocketElement) {
        self.rocketsData = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerCells(nibName: ["TitleTableViewCell", "CollectionViewInCell", "RocketInfoTableViewCell", "ButtonLaunchesTableViewCell", "TonAndSecTableViewCell"])
        let imageHeader = setupHeader(tableView: tableView)
        getRocketImages(header: imageHeader)
        setupConstraints()
        
    }
    
    lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.hidesWhenStopped = true
        indicator.contentMode = .center
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        return indicator
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        return tableView
    }()
    
    func setupConstraints() {
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
        let size = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width)
        let header = StretchyHeader(frame: size)
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
        settingsVC.delegate = self
        settingsVC.heightSegment.selectedSegmentIndex = measure.getIndexFromUnit(unit: Unit(rawValue: heightUnit)!)
        settingsVC.diameterSegment.selectedSegmentIndex = measure.getIndexFromUnit(unit: Unit(rawValue: diameterUnit)!)
        settingsVC.massSegment.selectedSegmentIndex = measure.getIndexFromUnit(unit: Unit(rawValue: massUnit)!)
        settingsVC.payloadSegment.selectedSegmentIndex = measure.getIndexFromUnit(unit: Unit(rawValue: payloadUnit)!)
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
        return HeaderForSection(withTitle: title)
    }
}

//MARK: - SegmentedControl Delegate
extension ViewController: SegmentDelegate {
    func didSelectHeightSegment(_ selectedIndex: String) {
        heightUnit = selectedIndex
        tableView.reloadData()
    }
    
    func didSelectDiametrSegment(_ selectedIndex: String) {
        diameterUnit = selectedIndex
        tableView.reloadData()
    }
    
    func didSelectMassSegment(_ selectedIndex: String) {
        massUnit = selectedIndex
        tableView.reloadData()
    }
    
    func didSelectPayloadSegment(_ selectedIndex: String) {
        payloadUnit = selectedIndex
        tableView.reloadData()
    }
}

//MARK: - UIScrollView delegate methods
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? StretchyHeader else { return }
        header.scrollViewDidScroll(scrollView: tableView)
    }
}

