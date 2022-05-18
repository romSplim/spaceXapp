//
//  Measure.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 16.05.2022.
//

import Foundation

struct Measure {
    var unit: Unit?
    var index: Int {
        getIndexFromUnit(unit: unit!)
    }
    
    func getIndexFromUnit(unit: Unit) -> Int {
        switch unit {
        case .m, .kg:
            return 0
        case .ft, .lb:
            return 1
        }
    }
}


