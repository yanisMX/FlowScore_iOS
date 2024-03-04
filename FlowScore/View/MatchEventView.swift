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
                                    
                                    
                                    
                                    
                                    
                                    Text(match.match_id).foregroundColor(.white)
                                    Button(action: {
                                        isShowingPopover = true
                                    }) {
                                        Text(match.league_id)
                                        Text("Voir + de détails")
                                            .font(.system(size: 15))
                                            .multilineTextAlignment(.center)
                                            .frame(width: 200, height: 20)
                                            .background(Color.blue)
                                            .clipShape(Capsule())
                                            .foregroundColor(.white)
                                    }
                                    .popover(isPresented: $isShowingPopover, content: {
                                        ScrollView{
                                            VStack{
                                                
                                                Text("Match referee : " + match.match_referee).foregroundStyle(.white)
                                                Text("Stadium : " + match.match_stadium).foregroundStyle(.white)
                                            }
                                           // ici je veux un espace
                                            VStack{
                                                Text("Test")
                                            }
                                            VStack{
                                                HStack {
                                                    VStack(alignment: .leading) {
                                                        HStack{
                                                            AsyncImage(url: URL(string: match.team_home_badge))
                                                            {
                                                                image in image.resizable()
                                                            } placeholder: {
                                                                ProgressView()
                                                            } .frame(maxWidth: 50, maxHeight: 50)
                                                            // Affichage du nom de l'équipe à l'extérieur et de son score
                                                            Text(match.match_hometeam_name + " " + match.match_hometeam_score)
                                                                .foregroundColor(match.match_hometeam_score == match.match_awayteam_score ? .white : (match.match_awayteam_score > match.match_hometeam_score ? .green : .red))
                                                                .fontWeight(.bold)
                                                                .font(.system(size: 18))
                                                        }
                                                        
                                                        // Affichage de la composition de l'équipe à domicile
                                                        ForEach(match.lineup.home.starting_lineups) { lineup in
                                                            VStack {
                                                                
                                                                Button(action: {
                                                                    
                                                                    Task {
                                                                        await findAndShowPlayerDetails(name: lineup.lineup_player)
                                                                    }
                                                                }) {
                                                                    Text(lineup.lineup_player)
                                                                    Text(lineup.lineup_number)
                                                                        .font(.system(size: 15))
                                                                        .foregroundColor(.white)
                                                                }
                                                                
                                                            } //VSTACK
                                                        }//: ForEACH
                                                        
                                                        
                                                    }// VSTACK
                                                    
                                                    .padding(.horizontal, 10)
                                                    
                                                    VStack(alignment: .leading) {
                                                        // Affichage du nom de l'équipe à l'extérieur et de son score
                                                        HStack{
                                                            Text(match.match_awayteam_score + " " + match.match_awayteam_name)
                                                                .foregroundColor(match.match_hometeam_score == match.match_awayteam_score ? .white : (match.match_awayteam_score > match.match_hometeam_score ? .green : .red))
                                                                .fontWeight(.bold)
                                                                .font(.system(size: 18))
                                                            
                                                            AsyncImage(url: URL(string: match.team_away_badge))
                                                            {
                                                                image in image.resizable()
                                                            } placeholder: {
                                                                ProgressView()
                                                            } .frame(maxWidth: 50, maxHeight: 50)
                                                        }
                                                        
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
                                                                    Text(lineup.lineup_position)
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
                                        }                                            
                                        .frame(maxWidth: 20, maxHeight: 20)
                                        
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

    func findAndShowPlayerDetails(name: String) async {
        // Extraction du prénom et du nom si nécessaire
        let playerNameComponents = name.components(separatedBy: " ")
        let lastName = playerNameComponents.last ?? ""
        await playerModel.fetchDataPlayers(selectedPlayer: lastName)

        // Trouver le joueur qui correspond le mieux en termes de nom et de longueur de nom
        let bestMatch = playerModel.players.first { player in
            guard let playerLastName = player.player_name.components(separatedBy: " ").last else { return false }
            return playerLastName.lowercased() == lastName.lowercased()
        }
        
        DispatchQueue.main.async {
            if let playerSelected = bestMatch {
                self.selectedPlayerDetails = playerSelected
                self.isDetailsPlayerViewPresented = true
            } else {
                print("Aucun joueur correspondant trouvé.")
                // Vous pourriez vouloir gérer ce cas, par exemple, en affichant un message à l'utilisateur
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
