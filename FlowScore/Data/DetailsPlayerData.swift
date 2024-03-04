//
//  DetailsPlayerData.swift
//  FlowScore
//
//  Created by Yanis Mohamed on 28/02/2024.
//

import Foundation

struct PlayersList: Codable {
    let player_key: Int
    let player_id: String
    let player_image: String
    let player_name: String
    let player_number: String
    let player_country: String
    let player_type: String
    let player_age: String
    let player_birthdate: String
    let player_match_played: String
    let player_goals: String
    let player_yellow_cards: String
    let player_red_cards: String
    let player_minutes: String
    let player_injured: String
    let player_substitute_out: String
    let player_substitutes_on_bench: String
    let player_assists: String
    let player_is_captain: String
    let player_shots_total: String
    let player_goals_conceded: String
    let player_fouls_committed: String
    let player_tackles: String
    let player_crosses_total: String
    let player_interceptions: String
    let player_clearances: String
    let player_dispossesed: String
    let player_duels_total: String
    let player_duels_won: String
    let player_dribble_attempts: String
    let player_dribble_succ: String
    let player_pen_scored: String
    let player_pen_missed: String
    let player_passes: String
    let player_passes_accuracy: String
    let player_key_passes: String
    let player_rating: String
    let team_name: String
    let team_key: String
    
}


extension PlayersList {
    static let previewPlayer = PlayersList(
        player_key: 323235386,
        player_id: "323235386",
        player_image: "https://apiv3.apifootball.com/badges/players/9898_k-benzema.jpg",
        player_name: "K. Benzema",
        player_number: "9",
        player_country: "",
        player_type: "Forwards",
        player_age: "35",
        player_birthdate: "1987-12-19",
        player_match_played: "23",
        player_goals: "18",
        player_yellow_cards: "1",
        player_red_cards: "0",
        player_minutes: "1970",
        player_injured: "Yes",
        player_substitute_out: "5",
        player_substitutes_on_bench: "0",
        player_assists: "3",
        player_is_captain: "23",
        player_shots_total: "77",
        player_goals_conceded: "0",
        player_fouls_committed: "10",
        player_tackles: "10",
        player_crosses_total: "3",
        player_interceptions: "2",
        player_clearances: "5",
        player_dispossesed: "27",
        player_duels_total: "128",
        player_duels_won: "49",
        player_dribble_attempts: "41",
        player_dribble_succ: "19",
        player_pen_scored: "6",
        player_pen_missed: "1",
        player_passes: "1022",
        player_passes_accuracy: "888",
        player_key_passes: "48",
        player_rating: "7.51",
        team_name: "Real Madrid",
        team_key: "76"
    )
}

