//
//  MatchEventView.swift
//  FlowScore
//
//  Created by SDV Bordeaux on 18/01/2024.
//

import SwiftUI

struct MatchEventView: View {
    
    @StateObject var matchesModel = MatchEventsModel()
    @State private var isShowingPopover = false
    
    let league: LeaguesList
    let backgroundBlack = Color.black
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Matchs du jour")
                    .font(Font.custom("Inspiration", size: 50))
                    .foregroundColor(.white)
                
                ScrollView {
                    
                    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                  
               ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                    ForEach(matchesModel.matches) { match in
                        
                        // INITIALISATION POUR COMPO//
                        let system_away = match.match_awayteam_system
                        var numberOfDefenders = 0

                        
                        if let defenderCount = system.components(separatedBy: "-").first,
                           let count = Int(defenderCount) {
                            numberOfDefenders = count
                        }                        
                //////////////////////////////////////////////////////////
                        
                        
                        VStack {
                            DisclosureGroup {
                                VStack{
                                    HStack {
                                        VStack{
                                            ForEach(match.lineup.home.starting_lineups) { lineup in
                                                HStack {
                                                    
                                                    Text(lineup.lineup_player).font(.system(size:15))
                                                    Spacer()
                                                    Text(lineup.lineup_number)
                                                }
                                                .foregroundColor(.white)
                                                
                                            }
                                        }
                                        VStack{
                                            ForEach(match.lineup.away.starting_lineups) { lineup in
                                                HStack {
                                                    Text(lineup.lineup_number)
                                                    Spacer()
                                                    Text(lineup.lineup_player).font(.system(size:15))
                                                }
                                                .foregroundColor(.white)
                                            }// Foreach 2
                                        } // Vstack
                                    } // :HSTACK
                                    Button(action: {
                                        isShowingPopover = true
                                    }) {
                                        Text("Voir + de détails")
                                            .font(.system(size: 15))
                                            .multilineTextAlignment(.center)
                                            .frame(width: 200, height: 20)
                                            .background(Color.blue)
                                            .clipShape(Capsule())
                                            .foregroundColor(.white)
                                    }
                                    .popover(isPresented: $isShowingPopover, content: {
                                        ZStack {
                                            Rectangle()
                                                .frame(width: 400, height: 300)
                                                .foregroundColor(.white)
                                            
                                            Rectangle()
                                                .frame(width: 390, height: 295)
                                                .foregroundColor(.green)
                                            
                                            Circle()
                                                .frame(width: 100)
                                                .foregroundColor(.white)
                                            
                                            Circle()
                                                .frame(width: 95)
                                                .foregroundColor(.green)
                                            
                                            Rectangle()
                                                .frame(width: 3, height: 300)
                                                .foregroundColor(.white)
                                        
                                            ZStack {
                                                HStack {
                                                    Rectangle()
                                                        .frame(width: 70, height: 160)
                                                        .foregroundColor(.white)
                                                    
                                                    Spacer()
                                                    
                                                    Rectangle()
                                                        .frame(width: 70, height: 160)
                                                        .foregroundColor(.white)
                                                } //: HSTACK
                                                
                                                HStack {
                                                    ZStack{
                                                        Rectangle()
                                                            .frame(width: 68, height: 157)
                                                            .foregroundColor(.green)
                                                        
                                                        Image("maillotext")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 30, height: 30)
                                                            .offset(x:-10)
                                                    }
                                                    
                                                    Spacer()
                                                    
                                                    ZStack{
                                                        Rectangle()
                                                            .frame(width: 68, height: 157)
                                                            .foregroundColor(.green)
                                                        
                                                        Image("mailotdom")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 30, height: 30)
                                                            .offset(x:10)
                                                        
                                                    }
                                                    
                                                } //: HSTACK
                                                
                                                
                                                ForEach(1..<7) { index in
                                                    let yOffset = CGFloat(index * 50 - 175)
                                                    
                                                    Image("maillotext")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 30, height: 30)
                                                        .offset(x: 0, y: yOffset)
                                                }.offset(x:-130)
                                                
                                                ForEach(1..<7) { index in
                                                    let yOffset = CGFloat(index * 50 - 175)
                                                    
                                                    Image("maillotext")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 30, height: 30)
                                                        .offset(x: 0, y: yOffset)
                                                }.offset(x:-90)

                                                ForEach(1..<7) { index in
                                                    let yOffset = CGFloat(index * 50 - 175)
                                                    
                                                    Image("maillotext")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 30, height: 30)
                                                        .offset(x: 0, y: yOffset)
                                                }.offset(x:-55)

                                                ForEach(1..<7) { index in
                                                    let yOffset = CGFloat(index * 50 - 175)
                                                    
                                                    Image("maillotext")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 30, height: 30)
                                                        .offset(x: 0, y: yOffset)
                                                }.offset(x:-20)
                                                
                                                
                                                ForEach(1..<7) { index in
                                                    let yOffset = CGFloat(index * 50 - 175)
                                                    
                                                    Image("mailotdom")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 30, height: 30)
                                                        .offset(x: 0, y: yOffset)
                                                }.offset(x:130)
                                                
                                                ForEach(1..<7) { index in
                                                    let yOffset = CGFloat(index * 50 - 175)
                                                    
                                                    Image("mailotdom")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 30, height: 30)
                                                        .offset(x: 0, y: yOffset)
                                                }.offset(x:90)

                                                ForEach(1..<7) { index in
                                                    let yOffset = CGFloat(index * 50 - 175)
                                                    
                                                    Image("mailotdom")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 30, height: 30)
                                                        .offset(x: 0, y: yOffset)
                                                }.offset(x:55)

                                                ForEach(1..<7) { index in
                                                    let yOffset = CGFloat(index * 50 - 175)
                                                    
                                                    Image("mailotdom")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 30, height: 30)
                                                        .offset(x: 0, y: yOffset)
                                                }.offset(x:20)
                                                
                                                
                                                
                                            } //: ZSTACK
                                            
                                        } //: ZSTACK
                                            Spacer()
                                            // Code ici
                                            HStack{
                                                Text(match.match_hometeam_score)
                                                    .foregroundColor(match.match_hometeam_score > match.match_awayteam_score ? .green : .white)
                                                Text("-")
                                                Text(match.match_awayteam_score)
                                                    .foregroundColor(match.match_awayteam_score > match.match_hometeam_score ? .green : .white)
                                                
                                            }
                                            .foregroundColor(.white)
                                            .fontWeight(.bold)
                                            .font(.system(size: 38))
                                            VStack{
                                                Text("to be continued")
                                            }
                                            .foregroundColor(.white)
                                            
                                            Spacer()
                                        }//:VSTACK
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                        .background(Color.black)
                                        .cornerRadius(10)
                                        .padding()
                                             };))
                                    
                                } // :VSTACK
                            } label: {
                                HStack {
                                    VStack {
                                        Text(
                                            match.match_live == "1" ?
                                            match.match_status + "'" :
                                                match.match_time
                                        ).foregroundStyle(Color.white)
                                    }
                                }
                                VStack(alignment: .leading) {
                                    HStack(alignment: .top) {
                                        AsyncImage(url: URL(string: match.team_home_badge))
                                        {
                                            image in image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }                                            .frame(maxWidth: 20, maxHeight: 20)
                                        
                                        Text(match.match_hometeam_name).foregroundStyle(Color.white)
                                        Spacer()
                                        Text(match.match_hometeam_score)
                                            .foregroundStyle(Color.white)
                                    }
                                    
                                    HStack {
                                        AsyncImage(url: URL(string: match.team_away_badge))
                                        {
                                            image in image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }                                        .frame(maxWidth: 20, maxHeight: 20)
                                        
                                        Text(match.match_awayteam_name).foregroundStyle(Color.white)
                                        Spacer()
                                        Text(match.match_awayteam_score).foregroundStyle(Color.white)
                                    }
                                }
                            }
                            .padding()
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .shadow(radius: 5)
                            .padding(.vertical, 10)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(backgroundBlack)
        }
        .task {
            await matchesModel.fetchDataMatchs(selectedLeague: league.league_id)
        }
    }
}


// MARK: PREVIEW
#Preview {
    MatchEventView(league: LeaguesList.previewLeagues)
}

