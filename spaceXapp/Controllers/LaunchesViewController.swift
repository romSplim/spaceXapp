//
//  LaunchesViewController.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 18.04.2022.
//

import UIKit

class LaunchesViewController: UIViewController {

    var rocketName: String?
    var rocketID: String = ""
    var launchesArr: [Launch]? {
        didSet {
            self.filterLaunches(rocketId: self.rocketID)
        }
    }
    var filteredArr: [Launch]?
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 30
        tableView.isHidden = true
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.hidesWhenStopped = true
        indicator.contentMode = .center
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        super.viewDidLoad()
        setupConstraints()
        getLaunchesRequest()
        setupNavBar()
        
        title = rocketName
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        tableView.register(UINib(nibName: "LaunchesTableViewCell", bundle: nil), forCellReuseIdentifier: "LaunchesTableViewCell")
        
    }
    
    func filterLaunches(rocketId: String) {
        let filteredResult = launchesArr?.filter { $0.rocket == Rocket(rawValue: rocketId) }
        filteredArr = filteredResult?.reversed()
    }
    
    func convertDate(model: Launch) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone
        guard let dataDate = dateFormatter.date(from: model.dateUTC ) else { return ""}
        dateFormatter.dateFormat = "d MMMM, Y"
        dateFormatter.locale = Locale(identifier: "ru")
        let newStringDate = dateFormatter.string(from: dataDate)
        return newStringDate
    }
    
    func getLaunchesRequest() {
        NetworkService.shared.getLaunches { [weak self] data, error in
            DispatchQueue.main.async {
                self?.launchesArr = data
                self?.tableView.reloadData()
                self?.indicator.stopAnimating()
                self?.tableView.isHidden = false
            }
        }
    }

    func setupNavBar() {
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.tintColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        navigationController?.navigationBar.backItem?.title = "Назад"
    }
    
    func setupConstraints() {
        view.addSubview(indicator)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - Table view data source
extension LaunchesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArr?.count ?? 0
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchesTableViewCell", for: indexPath) as? LaunchesTableViewCell else { return UITableViewCell()}
        if let launch = filteredArr?[indexPath.row] {
            let formattedDate = convertDate(model: launch)
            cell.getLaunchStatus(model: launch)
            cell.launchNameLbl.text = launch.name
            cell.launchDateLbl.text = formattedDate
        }
        
        return cell
    }
}
