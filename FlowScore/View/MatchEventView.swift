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
    @State private var isLoading = false
    
    
    let league: LeaguesList
    let backgroundBlack = Color.black
    
    
        var body: some View {
            NavigationStack {
                VStack {
                    Text("Matchs du jour")
                        .font(Font.custom("Inspiration", size: 50))
                        .foregroundColor(.white)
                    
                    ScrollView {
                        ForEach(matchesModel.matches,id:\.match_id) {match in
                            
                            VStack {
                                DisclosureGroup {
                                    VStack{
                                                                                VStack {
                                            let allScorers = match.goalscorer.filter { $0.home_scorer != "" || $0.away_scorer != "" }
                                            let sortedScorers = allScorers.sorted { $0.time < $1.time }
                                            
                                            ForEach(sortedScorers, id: \.id) { scorer in
                                                if scorer.home_scorer != "" {
                                                    HStack {
                                                        Text("\(scorer.time)'")
                                                        Text("\(scorer.home_scorer)")
                                                        Text("(\(match.match_hometeam_name))")
                                                        Spacer()
                                                    }
                                                } else {
                                                    HStack {
                                                        Spacer()
                                                        Text("\(scorer.away_scorer)")
                                                        Text("(\(match.match_awayteam_name))")
                                                        Text("\(scorer.time)'")
                                                    }
                                                }
                                            }
                                            .foregroundColor(.blue)
                                        }
                                        
                                        
                                        // Hstack
                                        
                                        
                                        
                                        
                                        
                                        
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
                                            VStack{
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
                                                .padding()
                                                // Code ici
                                                HStack {
                                                    VStack(alignment: .leading) {
                                                        Text(match.match_hometeam_name  + " " +  match.match_hometeam_score)
                                                            .foregroundColor(
                                                                match.match_hometeam_score == match.match_awayteam_score ?
                                                                    .white :
                                                                    (match.match_hometeam_score > match.match_awayteam_score ? .green : .red)
                                                            )
                                                            .fontWeight(.bold)
                                                            .font(.system(size: 18))
                                                        
                                                        VStack(alignment: .leading) {
                                                            ForEach(match.lineup.home.starting_lineups) { lineup in
                                                                HStack {
                                                                    Text(lineup.lineup_player)
                                                                        .font(.system(size: 15))
                                                                }
                                                                .foregroundColor(.white)
                                                                
                                                            }
                                                        }
                                                    }
                                                    .padding(.horizontal, 10)
                                                    
                                                    VStack(alignment: .leading) {
                                                        Text(match.match_awayteam_name + " " + match.match_awayteam_score)
                                                            .foregroundColor(
                                                                match.match_hometeam_score == match.match_awayteam_score ?
                                                                    .white :
                                                                    (match.match_awayteam_score > match.match_hometeam_score ? .green : .red)
                                                            )
                                                            .fontWeight(.bold)
                                                            .font(.system(size: 18))
                                                        Text(league.league_id)
                                                        VStack(alignment: .leading) {
                                                            ForEach(match.lineup.away.starting_lineups) { lineup in
                                                                
                                                                HStack {
                                                                    Text(lineup.lineup_player)
                                                                        .font(.system(size: 15))
                                                                }
                                                                .foregroundColor(.white)
                                                                
                                                            }
                                                        }
                                                    }
                                                    .padding(.horizontal, 10)
                                                }// : Hstack
                                                
                                                .foregroundColor(.white)
                                                
                                            }//:VSTACK
                                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                            .background(Color.black)
                                            .cornerRadius(10)
                                            .padding()
                                        })
                                        
                                    } // :VSTACK
                                } label: {
                                    HStack {
                                        VStack {
                                            Text(
                                                match.match_live == "1" ?
                                                match.match_status + "'" :
                                                    (match.match_time < getCurrentTime() ? "Finished" : match.match_time)                                        ).foregroundStyle(Color.white)
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
                                           
                                            AsyncImage(url: URL(string: match.team_away_badge)) { image in
                                                image.resizable()
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .frame(maxWidth: 20, maxHeight: 20)

                                            Text(match.match_awayteam_name)
                                                .foregroundStyle(Color.white)

                                            Spacer()

                                            Text(match.match_awayteam_score)
                                                .foregroundStyle(Color.white)
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
            .refreshable{
                await fetchData()
            }
            
        }
        
        
        func fetchData() async {
            isLoading = true
            await matchesModel.fetchDataMatchs(selectedLeague: league.league_id)
            isLoading = false
            print("Data refreshed")
        }
        func getCurrentTime() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            return dateFormatter.string(from: Date())
        }
        
    }
    


// MARK: PREVIEW
#Preview {
    MatchEventView(league: LeaguesList.previewLeagues)
}

