//
//  LeaguesModel.swift
//  FlowScore
//
//  Created by SDV Bordeaux on 18/01/2024.
//

import Foundation

class LeaguesModel: ObservableObject {
    
    @Published var leagues = [LeaguesList] ()

    func fetchDataLeagues(selectedCountry countryId: String) async {
        guard let url = URL(string: "https://apiv3.apifootball.com/?action=get_leagues&country_id=\(countryId)&APIkey=7bc8fa479f995fd249bc72bfc0344c87b0ed2aecd03123167b9017c91278b6fa") else {
            print("URL invalid")
            return
        }
        do {
            let (data, response) = try await URLSession.shared.data(from:url)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let decodeResponse = try JSONDecoder().decode([LeaguesList].self, from:data)
                    DispatchQueue.main.async {
                        self.leagues = decodeResponse
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


