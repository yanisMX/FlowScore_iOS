//
//  FootballModel.swift
//  FlowScore
//
//  Created by SDV Bordeaux on 18/01/2024.
//

import Foundation


class CountriesModel: ObservableObject {
    
    @Published var countries = [CountryList] ()
    var URLKey = "f7417cd8d5b9eb3f04494ab54cb43d65f455839fd18839caef1a9205e96a7562"

    func fetchDataCountries() async {
        guard let url = URL(string: "https://apiv3.apifootball.com/?action=get_countries&APIkey=\(URLKey)") else{
            print("URL invalid")
            return
        }
        do {
            let (data, response) = try await URLSession.shared.data(from:url)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let decodeResponse = try JSONDecoder().decode([CountryList].self, from:data)
                    DispatchQueue.main.async {
                        self.countries = decodeResponse
                    }//:async
                }//:do
                catch {
                    print("JSON decoding error: \(error)")
                }
                
                }//:if
            else {
                    print("HTTP ERROR: status cod isn't 200")
            }
            }//:do
        catch {
                print("Network Request error: \(error)")
        }
    }//:func
}//:Class

