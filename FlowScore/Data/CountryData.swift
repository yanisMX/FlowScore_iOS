//
//  CountryData.swift
//  FlowScore
//
//  Created by Yanis Mohamed on 18/01/2024.
//

import Foundation

struct CountryList: Codable, Identifiable {
    let country_id: String
    let country_name: String
    let country_logo: String
    var id: String {country_id}
    
}

extension CountryList {
    static let previewCountry:   CountryList =
        CountryList(country_id: "1", country_name: "Espagne", country_logo: "espagne")
}
