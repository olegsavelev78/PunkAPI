//
//  BeersData.swift
//  TestPunkAPI
//
//  Created by Олег Савельев on 23.06.2021.
//

import Foundation

struct BeerData: Codable {
    let id: Int
    let name: String
    let image_url: String
    let description: String
}
