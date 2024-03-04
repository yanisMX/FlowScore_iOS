//
//  LeaguesData.swift
//  FlowScore
//
//  Created by SDV Bordeaux on 18/01/2024.
//

import Foundation




struct LeaguesList: Codable, Identifiable {
    let country_id: String
    let country_name: String
    let country_logo:String
    let league_id: String
    let league_name: String
    let league_season:String
    let league_logo:String
    
    var id: Int {
        if let intId = Int(league_id) {
            return intId
        } else {
            return 0
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(country_id)
    }
    
}

extension LeaguesList {
    static let previewLeagues:   LeaguesList =
    LeaguesList(country_id: "6", country_name: "Espagne",country_logo: "espagne", league_id: "111", league_name: "Copa del Rey", league_season: "2023/2024",league_logo: "espagne")
}


