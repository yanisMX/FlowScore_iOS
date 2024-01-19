//
//  MatchEventData.swift
//  FlowScore
//
//  Created by SDV Bordeaux on 18/01/2024.
//

import Foundation

struct MatchEventList: Codable, Identifiable {
    
    let match_id :String
    let league_id :String
    let league_name:String
    let match_date:String
    let match_status:String
    let match_time:String
    let match_hometeam_id:String
    let match_hometeam_name:String
    let match_hometeam_score:String
    let match_awayteam_name:String
    let match_awayteam_id:String
    let match_awayteam_score:String
    let match_live:String
    let match_round:String
    let match_stadium:String
    let match_referee:String
    let team_home_badge:String
    let team_away_badge:String

var id: Int {
    if let intId = Int(match_id) {
        return intId
    } else {
        return 0
    }
}


}

extension MatchEventList {
    static let previentMatchEvent:   MatchEventList =
    MatchEventList(match_id: "1", league_id: "2", league_name: "Premier league", match_date: "2024-01-18", match_status: "Live", match_time: "16:00", match_hometeam_id: "10", match_hometeam_name: "Chelsea", match_hometeam_score: "2", match_awayteam_name: "Liverpool", match_awayteam_id: "50", match_awayteam_score: "0", match_live: "1", match_round: "2", match_stadium: "jsp", match_referee: "moi", team_home_badge: "espagne", team_away_badge: "france")
}

