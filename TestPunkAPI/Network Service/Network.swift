//
//  Network.swift
//  TestPunkAPI
//
//  Created by Олег Савельев on 23.06.2021.
//

import Foundation

class Network {
    
    static let shared = Network()
    var isPagination = false
    var page = 0
    
    func getData(pagination: Bool = false, completion: @escaping([Beers]) -> Void) {
        
        if pagination {
            isPagination = true
            page += 1
        }
        let url = "https://api.punkapi.com/v2/beers?page=\(page)&per_page=10"
        guard let urlString = URL(string: url) else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: urlString) { data, response, error in
            if let data = data, error == nil {
                if let beers = self.parseJSON(data: data) {
                        completion(beers)
                    }
            }
        }
        task.resume()
        if pagination {
            self.isPagination = false
        }
    }
    
    private func parseJSON(data: Data) -> [Beers]? {
        let decoder = JSONDecoder()
        do {
            let beersData = try decoder.decode([BeerData].self, from: data)
            var beersArray: [Beers] = []
            for item in beersData {
                guard let beers = Beers(beersData: item) else {
                    return nil
                }
                beersArray.append(beers)
            }
            return beersArray
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
