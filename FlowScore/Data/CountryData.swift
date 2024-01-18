//
//  CountryData.swift
//  FlowScore
//
//  Created by Yanis Mohamed on 18/01/2024.
//

import Foundation

struct CountryList: Codable, Identifiable {
    let country_id: Int
    let country_name: String
    let country_logo: String
    
    var id: Int {country_id}
    
}

extension CountryList {
    static let previewCountry:   [CountryList] = [
        CountryList(country_id: 1, country_name: "Espagne", country_logo: "espagne"),
        CountryList(country_id: 2, country_name: "Angleterre", country_logo: "angleterre"),
        CountryList(country_id: 3, country_name: "France", country_logo: "france"),
        CountryList(country_id: 5, country_name: "Italie", country_logo: "italie")]
}
