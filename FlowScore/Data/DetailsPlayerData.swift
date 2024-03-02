//
//  DetailsPlayerData.swift
//  FlowScore
//
//  Created by Yanis Mohamed on 28/02/2024.
//

import Foundation

struct PlayersList: Codable {
    let playerKey: Int
    let playerId: String
    let playerImage: String
    let playerName: String
    let playerNumber: String
    let playerCountry: String
    let playerType: String
    let playerAge: String
    let playerBirthdate: String
    let playerMatchPlayed: String
    let playerGoals: String
    let playerYellowCards: String
    let playerRedCards: String
    let playerMinutes: String
    let playerInjured: String
    let playerSubstituteOut: String
    let playerSubstitutesOnBench: String
    let playerAssists: String
    let playerIsCaptain: String
    let playerShotsTotal: String
    let playerGoalsConceded: String
    let playerFoulsCommitted: String
    let playerTackles: String
    let playerCrossesTotal: String
    let playerInterceptions: String
    let playerClearances: String
    let playerDispossesed: String
    let playerDuelsTotal: String
    let playerDuelsWon: String
    let playerDribbleAttempts: String
    let playerDribbleSucc: String
    let playerPenScored: String
    let playerPenMissed: String
    let playerPasses: String
    let playerPassesAccuracy: String
    let playerKeyPasses: String
    let playerRating: String
    let teamName: String
    let teamKey: String
}

extension PlayersList {
    static let previewPlayer = PlayersList(
        playerKey: 323235386,
        playerId: "323235386",
        playerImage: "https://apiv3.apifootball.com/badges/players/9898_k-benzema.jpg",
        playerName: "K. Benzema",
        playerNumber: "9",
        playerCountry: "",
        playerType: "Forwards",
        playerAge: "35",
        playerBirthdate: "1987-12-19",
        playerMatchPlayed: "23",
        playerGoals: "18",
        playerYellowCards: "1",
        playerRedCards: "0",
        playerMinutes: "1970",
        playerInjured: "Yes",
        playerSubstituteOut: "5",
        playerSubstitutesOnBench: "0",
        playerAssists: "3",
        playerIsCaptain: "23",
        playerShotsTotal: "77",
        playerGoalsConceded: "0",
        playerFoulsCommitted: "10",
        playerTackles: "10",
        playerCrossesTotal: "3",
        playerInterceptions: "2",
        playerClearances: "5",
        playerDispossesed: "27",
        playerDuelsTotal: "128",
        playerDuelsWon: "49",
        playerDribbleAttempts: "41",
        playerDribbleSucc: "19",
        playerPenScored: "6",
        playerPenMissed: "1",
        playerPasses: "1022",
        playerPassesAccuracy: "888",
        playerKeyPasses: "48",
        playerRating: "7.51",
        teamName: "Real Madrid",
        teamKey: "76"
    )
}
