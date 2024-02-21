//
//  MatchEventsModel.swift
//  FlowScore
//
//  Created by SDV Bordeaux on 18/01/2024.
//

import Foundation

class MatchEventsModel: ObservableObject {
    
    @Published var matches = [MatchEventList] ()
     var URLkey = "f7417cd8d5b9eb3f04494ab54cb43d65f455839fd18839caef1a9205e96a7562"

    let format = DateFormatter()

    func fetchDataMatchs(selectedLeague leagueId: String) async {
        
        format.dateFormat = "yyyy-MM-dd"
        let currentDate = format.string(from: Date())
        
        
        guard let url = URL(string: "https://apiv3.apifootball.com/?action=get_events&from=\(currentDate)&to=\(currentDate)&league_id=\(leagueId)&APIkey=\(URLkey)") else {
            print("URL invalid")
            return
        }
        do {
            let (data, response) = try await URLSession.shared.data(from:url)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let decodeResponse = try JSONDecoder().decode([MatchEventList].self, from:data)
                    DispatchQueue.main.async {
                        self.matches = decodeResponse
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

