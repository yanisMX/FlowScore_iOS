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
        @State private var isDetailsPlayerViewPresented = false
        @State private var selectedPlayerDetails: PlayersList?
    @StateObject var playerModel = PlayerModel()

    
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
                                                        } //: Zstack
                                                        
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
                                                            
                                                        } // : ZStack
                                                        
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
                                            
                                            // Code ici
                                            HStack {
                                                VStack(alignment: .leading) {
                                                    // Affichage du nom de l'équipe à domicile et de son score
                                                    Text(match.match_hometeam_name + " " +  match.match_hometeam_score)
                                                        .foregroundColor(match.match_hometeam_score == match.match_awayteam_score ? .white : (match.match_hometeam_score > match.match_awayteam_score ? .green : .red))
                                                        .fontWeight(.bold)
                                                        .font(.system(size: 18))
                                                    
                                                    // Affichage de la composition de l'équipe à domicile
                                                    ForEach(match.lineup.home.starting_lineups) { lineup in
                                                        VStack {
                                                            
                                                            Button(action: {
                                                                
                                                                Task {
                                                                    await findAndShowPlayerDetails(name: lineup.lineup_player)
                                                                }
                                                            }) {
                                                                Text(lineup.lineup_player)
                                                                    .font(.system(size: 15))
                                                                    .foregroundColor(.white)
                                                            }
                                                            
                                                        } //VSTACK
                                                    }//: ForEACH
                                                    
                                                    
                                                }// VSTACK
                                            
                                            .padding(.horizontal, 10)
                                            
                                            VStack(alignment: .leading) {
                                                // Affichage du nom de l'équipe à l'extérieur et de son score
                                                Text(match.match_awayteam_name + " " + match.match_awayteam_score)
                                                    .foregroundColor(match.match_hometeam_score == match.match_awayteam_score ? .white : (match.match_awayteam_score > match.match_hometeam_score ? .green : .red))
                                                    .fontWeight(.bold)
                                                    .font(.system(size: 18))
                                                
                                                // Affichage de la composition de l'équipe à l'extérieur
                                                ForEach(match.lineup.away.starting_lineups) { lineup in
                                                    VStack {
                                                        Button(action: {
                                                            print("Button tapped, attempting to load player details...")
                                                            Task {
                                                                await findAndShowPlayerDetails(name: lineup.lineup_player)
                                                                
                                                            }
                                                        }) {
                                                            Text(lineup.lineup_player)
                                                                .font(.system(size: 15))
                                                                .foregroundColor(.white)
                                                        }
                                                        .sheet(isPresented: $isDetailsPlayerViewPresented) {
                                                            // Assurez-vous que selectedPlayerDetails n'est pas nil avant d'essayer de présenter DetailsPlayerView
                                                            if let playerDetails = selectedPlayerDetails {
                                                                DetailsPlayerView(player: playerDetails)
                                                            }
                                                        }
                                                        
                                                    }
                                                }
                                                
                                            }
                                            .padding(.horizontal, 10)
                                        }
                                        // : HSTACK
                                        
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
                                    }//HSTACK
                                    
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
                                    }//HSTACK
                                
                                }// VSTACK
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
    
    /*
    func findAndShowPlayerDetails(name: String) async {
        // Exemple d'objet de test pour Lionel Messi
        let testPlayerDetails = PlayersList(
            playerKey: 123456,
            playerId: "10",
            playerImage: "https://link.to/messi/image.jpg",
            playerName: "Lionel Messi",
            playerNumber: "10",
            playerCountry: "Argentina",
            playerType: "Forward",
            playerAge: "34",
            playerBirthdate: "1987-06-24",
            playerMatchPlayed: "5",
            playerGoals: "4",
            playerYellowCards: "0",
            playerRedCards: "0",
            playerMinutes: "450",
            playerInjured: "No",
            playerSubstituteOut: "0",
            playerSubstitutesOnBench: "0",
            playerAssists: "3",
            playerIsCaptain: "Yes",
            playerShotsTotal: "20",
            playerGoalsConceded: "0",
            playerFoulsCommitted: "1",
            playerTackles: "2",
            playerCrossesTotal: "10",
            playerInterceptions: "1",
            playerClearances: "0",
            playerDispossesed: "5",
            playerDuelsTotal: "30",
            playerDuelsWon: "20",
            playerDribbleAttempts: "15",
            playerDribbleSucc: "10",
            playerPenScored: "1",
            playerPenMissed: "0",
            playerPasses: "200",
            playerPassesAccuracy: "90%",
            playerKeyPasses: "10",
            playerRating: "8.5",
            teamName: "Paris Saint-Germain",
            teamKey: "123"
        )

        // Simule le processus d'assignation comme si les données venaient de l'API
        DispatchQueue.main.async {
            self.selectedPlayerDetails = testPlayerDetails
            self.isDetailsPlayerViewPresented = true
        }
    } */

    func findAndShowPlayerDetails(name: String) async {
        // Extraction du prénom et du nom si nécessaire
        let player_name = name.components(separatedBy: " ").last ?? ""
        print(player_name)
        await playerModel.fetchDataPlayers(selectedPlayer: player_name)
        
        if let playerSelected = playerModel.players.first {
                DispatchQueue.main.async {
                    self.selectedPlayerDetails = playerSelected
                    self.isDetailsPlayerViewPresented = true
                }
            }
    
    }
    

    
}//Body



// MARK: PREVIEW
struct MatchEventView_Previews: PreviewProvider {
    static var previews: some View {
        MatchEventView(league: LeaguesList.previewLeagues)
    }
}
