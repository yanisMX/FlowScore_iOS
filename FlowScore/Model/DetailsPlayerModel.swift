//
//  DetailsPlayerModel.swift
//  FlowScore
//
//  Created by Yanis Mohamed on 28/02/2024.
//

import Foundation

class PlayerModel: ObservableObject {
    
    @Published var players = [PlayersList] ()
    var URLKey = "f7417cd8d5b9eb3f04494ab54cb43d65f455839fd18839caef1a9205e96a7562"
  
    func fetchDataPlayers(selectedPlayer playerName: String) async {
        guard let url = URL(string: "https://apiv3.apifootball.com/?action=get_players&player_name=\(playerName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&APIkey=\(URLKey)") else {
            print("URL invalid")
            return
        }
        print("Fetching data for URL: \(url)")
        do {
            let (data, response) = try await URLSession.shared.data(from:url)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let decodeResponse = try JSONDecoder().decode([PlayersList].self, from:data)
                    DispatchQueue.main.async {
                        self.players = decodeResponse
                    }//:async
                }//:do
                catch {
                    print("JSON decoding error: \(error)")
                }
                
            }//:if
            else {
                print("HTTP ERROR: status code isn't 200")
            }
        }//:do
        catch {
            print("Network Request error: \(error)")
        }
    }//:func
}
