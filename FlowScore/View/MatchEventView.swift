//
//  MatchEventView.swift
//  FlowScore
//
//  Created by SDV Bordeaux on 18/01/2024.
//

import SwiftUI

struct MatchEventView: View {
    
// MARK : PROPERTIES
    @StateObject var matchesModel = MatchEventsModel()

    let league : LeaguesList
    
    let backgroundBlack = Color.black
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    
    
// MARK : BODY
    var body: some View {
        NavigationStack {
            VStack {
                Text("Matchs du jour")
                    .font(Font.custom("Inspiration", size: 50))
                    .foregroundColor(.white)
                    
                
                ScrollView {
                    ForEach(matchesModel.matches) { match in
                        VStack {
                            DisclosureGroup {
                                Text("Test")
                                
                            } label: {
                                HStack{
                                    VStack{
                                        Text(
                                            match.match_live == "1" ?
                                            match.match_status+"'" :
                                            match.match_time
                                        )
                                    }//:Vstack
                                }//:Hstack
                                VStack (alignment: .leading) {
                                    HStack (alignment: .top)
                                    {AsyncImage(url: URL(string: match.team_home_badge)){ logo in
                                        logo.resizable()
                                            
                                        
                                    } 
                                    
                                    
                                    placeholder: {
                                        ProgressView()
                                    }
                                    
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 20, maxHeight: 20)
                                    
                                        
                                        Text(match.match_hometeam_name)
                                        Spacer()
                                        Text(match.match_hometeam_score)
                                        
                                            
                                    }//:HStack
                                    
                                    
                                    HStack{
                                        AsyncImage(url: URL(string: match.team_away_badge)){ logo in
                                            logo.resizable()
                                            
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 20, maxHeight: 20)
                                        
                                        Text(match.match_awayteam_name)
                                        Spacer()
                                        Text(match.match_awayteam_score)
                                        
                                        
                                    }//:HStack

                                }//:VSTACK
                                
                                
                            }
                            .foregroundColor(.white)
                            .padding()
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .shadow(radius: 5)
                            .padding(.vertical, 10)
                        }
                    }
                }

            }//: VStack
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(backgroundBlack)
        }//: NavigationStack
        .task {
            await matchesModel.fetchDataMatchs(selectedLeague: league.league_id )
        }
    }//:BODY
}//:VIEW



// MARK : PREVIEW
#Preview {
    MatchEventView(league:LeaguesList.previewLeagues)
}

