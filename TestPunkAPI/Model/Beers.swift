//
//  Beers.swift
//  TestPunkAPI
//
//  Created by Олег Савельев on 23.06.2021.
//

import Foundation

struct Beers {
    let id: Int?
    let name: String?
    let imageURL: String?
    let description: String?
    
    
    //MARK: - Init
    init?(beersData: BeerData) {
        id = beersData.id
        name = beersData.name
        imageURL = beersData.image_url
        description = beersData.description
    }
}
