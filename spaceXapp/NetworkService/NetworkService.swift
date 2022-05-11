//
//  NetworkService.swift
//  spaceXapp
//
//  Created by Рамиль Ахатов on 05.04.2022.
//

import UIKit

class NetworkService {
    
    static let shared = NetworkService()
    
    func getRequest(completion: @escaping ([RocketElement]?,Error?) -> ()) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error)
            }
            
            guard let data = data else { return }
            
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 400 {
                completion(nil, error)
            } else {
                do {
                    let jsonData = try JSONDecoder().decode([RocketElement].self, from: data)
                    completion(jsonData, nil)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func getLaunches(completion: @escaping ([Launch]?,Error?) -> ()) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/launches") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error)
            }
            
            guard let data = data else { return }
            
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 400 {
                completion(nil, error)
            } else {
                do {
                    let jsonData = try JSONDecoder().decode([Launch].self, from: data)
                    completion(jsonData, nil)
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func fetchRocketImage(with model: RocketElement, completion: @escaping (Data) -> ()) {
        
        guard let randomRocketImg = model.flickrImages.randomElement() else { return }
        guard let url = URL(string: randomRocketImg) else { return }
        
        // Create Data Task
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }
        task.resume()
    }
}
