//
//  CountryView.swift
//  FlowScore
//
//  Created by Yanis Mohamed on 17/01/2024.
//

import SwiftUI

struct LeagueView: View {
    
    
    // MARK : PROPERTIES
    @StateObject var leaguesmodel = LeaguesModel()
    
    let country : CountryList
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    let backgroundBlack = Color.black

    
    // MARK : BODY
    var body: some View {
        NavigationStack {
            VStack {
                Text(country.country_name)
                    .font(Font.custom("Jomhuria", size:50))
                    .foregroundColor(.white)
                    .offset(y:-275)
                
                Text("Select Leagues")
                    .font(Font.custom("Inspiration", size: 50))
                    .foregroundColor(.white)
                
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(leaguesmodel.leagues) { league in
                            GroupBox {
                                VStack {
                                    AsyncImage(url: URL(string: league.league_logo)) { logo in
                                        logo.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .aspectRatio(contentMode: .fit)
                                    .shadow(radius: 5)
                                    .frame(maxWidth: 100, maxHeight: 100)
                                    
                                    Text(league.league_name)
                                        .font(Font.custom("Jomhuria", size: 50))
                                        .foregroundColor(.white)
                                        .offset(y: -20)
                                    
                                    NavigationLink(destination: MatchEventView(league: league)){
                                        Text("Select")
                                            .font(Font.custom("Katibeh", size: 25))
                                            .multilineTextAlignment(.center)
                                            .offset(y:5)
                                            .frame(width: 100, height: 30)
                                            .background(Color.white)
                                            .clipShape(Capsule())
                                            .foregroundColor(.black)
                                    }//:NavigationLink
                                    .offset(y: -50)
                                } //: VStack
                                .padding(5)
                            }
                        } //: ForEach
                    } //: LazyVGrid
                } //: ScrollView
            } //: VStack
            .background(backgroundBlack)
        } //: NavigationStack
        .task {
            await leaguesmodel.fetchDataLeagues(selectedCountry: country.country_id)
        } //: task
    }//:BODY
        
}//MARK : VIEW
#Preview {
    LeagueView(country: CountryList.previewCountry)
}

