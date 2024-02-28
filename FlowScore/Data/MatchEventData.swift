//
//  MatchEventData.swift
//  FlowScore
//
//  Created by SDV Bordeaux on 18/01/2024.
//

import Foundation

struct MatchEventList: Codable, Identifiable {
    let match_id: String
    var id: String { match_id }
   
    let league_id: String
    let league_name: String
    let match_date: String
    let match_status: String
    let match_time: String
    let match_hometeam_id: String
    let match_hometeam_name: String
    let match_hometeam_score: String
    let match_awayteam_name: String
    let match_awayteam_id: String
    let match_awayteam_score: String
    let match_live: String
    let match_round: String
    let match_stadium: String
    let match_referee: String
    let team_home_badge: String
    let team_away_badge: String
    let match_hometeam_system:String
    let match_awayteam_system:String
    let goalscorer:[Goalscorer]
    
    struct Goalscorer:Codable{
        let id = UUID()
        let time:String
        let home_scorer:String
        let home_assist:String
        let away_scorer:String
        let away_assist:String
    }
    
    let lineup: Lineup

    struct Lineup: Codable {
        let home: TeamLineup
        let away: TeamLineup
        
        struct TeamLineup: Codable {
            let starting_lineups: [StartingLineup]
            
            struct StartingLineup: Codable, Identifiable {
                let id = UUID()
                let lineup_player: String
                let lineup_number: String
                let lineup_position: String
            }
        }
    }
}




extension MatchEventList {
    static let previentMatchEvent = MatchEventList(
        match_id: "112282",
        league_id: "164",
        league_name: "Premier League",
        match_date: "2023-04-05",
        match_status: "Finished",
        match_time: "21:00",
        match_hometeam_id: "3081",
        match_hometeam_name: "West Ham United",
        match_hometeam_score: "1",
        match_awayteam_name: "Newcastle United",
        match_awayteam_id: "3100",
        match_awayteam_score: "5",
        match_live: "0",
        match_round: "7",
        match_stadium: "London Stadium (London)",
        match_referee: "C. Pawson",
        team_home_badge: "https://apiv3.apifootball.com/badges/3081_west-ham-united.jpg",
        team_away_badge: "https://apiv3.apifootball.com/badges/3100_newcastle-united.jpg",
        match_hometeam_system:"4-4-2",
        match_awayteam_system:"4-3-3",
        goalscorer:[MatchEventList.Goalscorer(time: "6", home_scorer: "OPenda", home_assist: "YAnis M", away_scorer: "", away_assist: "")],
        lineup: MatchEventList.Lineup(
            home: MatchEventList.Lineup.TeamLineup(
                starting_lineups: [
                    MatchEventList.Lineup.TeamLineup.StartingLineup(
                        lineup_player: "Lukasz Fabianski",
                        lineup_number: "1",
                        lineup_position: "1"
                    ),
                    MatchEventList.Lineup.TeamLineup.StartingLineup(
                        lineup_player: "Thilo Kehrer",
                        lineup_number: "24",
                        lineup_position: "2"
                    )
                ]
                ),
            away: MatchEventList.Lineup.TeamLineup(
                starting_lineups: [
                    MatchEventList.Lineup.TeamLineup.StartingLineup(
                        lineup_player: "Lukasz Fabianski",
                        lineup_number: "1",
                        lineup_position: "1"
                    ),
                    MatchEventList.Lineup.TeamLineup.StartingLineup(
                        lineup_player: "Thilo Kehrer",
                        lineup_number: "24",
                        lineup_position: "2"
                    )
                ]            
            )
        )
    )
}

