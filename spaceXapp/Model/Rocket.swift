//
//  Rocket.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 05.04.2022.
//

import Foundation

struct RocketElement: Codable {
    let height, diameter: Diameter
    let mass: Mass
    let firstStage: FirstStage
    let secondStage: SecondStage
    let id: String
    let payloadWeights: [PayloadWeight]
    let flickrImages: [String]
    let name, type: String
    let stages, boosters, costPerLaunch, successRatePct: Int
    let firstFlight, country, company: String
    
    enum CodingKeys: String, CodingKey {
        case height, diameter, mass
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case payloadWeights = "payload_weights"
        case flickrImages = "flickr_images"
        case name, type, stages, boosters
        case costPerLaunch = "cost_per_launch"
        case successRatePct = "success_rate_pct"
        case firstFlight = "first_flight"
        case country, company, id
        
    }
}

struct Diameter: Codable {
    let meters, feet: Double?
}
struct Mass: Codable {
    let kg, lb: Int
}
struct PayloadWeight: Codable {
    let id, name: String
    let kg, lb: Int
}


struct FirstStage: Codable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?

    enum CodingKeys: String, CodingKey {
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
    }
}

struct SecondStage: Codable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?

    enum CodingKeys: String, CodingKey {
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
    }
}
