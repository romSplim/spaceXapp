//
//  RocketInfoTableViewCell.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 03.04.2022.
//

import UIKit

class RocketInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .black
        textLbl.sizeToFit()
        valueLbl.sizeToFit()
        textLbl.font = UIFont(name: "LabGrotesque-Regular", size: 16)
        valueLbl.font = UIFont(name: "LabGrotesque-Regular", size: 16)
        textLbl.textColor = UIColor(red: 0.79, green: 0.79, blue: 0.79, alpha: 1)
        valueLbl.textColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
    }
    
    func convertDate(model: RocketElement) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")! as TimeZone
        dateFormatter.locale = Locale(identifier: "ru")
        guard let dataDate = dateFormatter.date(from: model.firstFlight) else { return ""}
        dateFormatter.dateFormat = "d MMMM, Y"
        let newStringDate = dateFormatter.string(from: dataDate)
        return newStringDate
    }
    
    func fetchCellWithData(model: RocketElement, countriesDict: [String: String] , indexPath: IndexPath) {
        
        let textForThirdSection = ["Первый запуск","Страна","Стоимость запуска"]
        
        if indexPath.section == 2 {
            let formattedFirstFlightDate = convertDate(model: model)
            let localizedCountry = countryName(countries: countriesDict, model: model)
            let formattedCostPerLaunch = formatPoints(from: model.costPerLaunch)
            let valuesForThirdSection = [formattedFirstFlightDate, localizedCountry, formattedCostPerLaunch]
            textLbl.text = textForThirdSection[indexPath.row]
            valueLbl.text = valuesForThirdSection[indexPath.row]
        }
    }
    
    func formatPoints(from: Int) -> String {
        
        let number = Double(from)
        let thousand = number / 1000
        let million = number / 1000000
        let billion = number / 1000000000
        
        if billion >= 1.0 {
            return "$\(Int(round(billion*10)/10)) млрд"
        } else if million >= 1.0 {
            return "$\(Int(round(million*10)/10)) млн"
            
        } else if thousand >= 1.0 {
            return "$\(Int(round(thousand*10)/10)) тыс"
        } else {
            return "$\(Int(number))"
        }
    }
    
    func countryName(countries: [String: String], model: RocketElement) -> String? {
        let key = model.country
//        let country = countries[key]
        return countries[key]
    }
}
