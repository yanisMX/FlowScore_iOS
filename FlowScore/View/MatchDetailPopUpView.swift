import SwiftUI

struct MatchDetailPopUpView: View {
    @StateObject var matchesModel = MatchEventsModel()
    @State private var isShowingPopover = false
    @State private var isLoading = false
    @State private var isDetailsPlayerViewPresented = false
    @State private var selectedPlayerDetails: PlayersList?
    @StateObject var playerModel = PlayerModel()
    
    let league: LeaguesList
    let backgroundBlack = Color.black
    
    var body: some View {
        ForEach(matchesModel.matches,id:\.match_id) {match in
            ScrollView{
                VStack{
                    Spacer().frame(height:20)
                    HStack{
                        // Affichage du nom de l'équipe à l'extérieur et de son score
                        AsyncImage(url: URL(string: match.team_home_badge))
                        {
                            image in image.resizable()
                        } placeholder: {
                            ProgressView()
                        } .frame(maxWidth: 50, maxHeight: 50)
                        
                        Text(match.match_hometeam_name + " " + match.match_hometeam_score)
                            .foregroundColor(match.match_hometeam_score == match.match_awayteam_score ? .white : (match.match_awayteam_score > match.match_hometeam_score ? .green : .red))
                            .fontWeight(.bold)
                            .font(.system(size: 18))
                        Text(" - ")
                        // Affichage du nom de l'équipe à l'extérieur et de son score
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
                    
                    
                    Text("Referee: " + match.match_referee).foregroundStyle(.white)
                    Text("Stadium : " + match.match_stadium).foregroundStyle(.white)
                    Spacer().frame(height:20)
                    Text("LINEUPS").foregroundStyle(.white)
                        .font(Font.custom("Jomhuria", size: 50))
                    HStack {
                        VStack(alignment: .leading) {
                            
                            
                            // Affichage de la composition de l'équipe à domicile
                            ForEach(match.lineup.home.starting_lineups) { lineup in
                                VStack {
                                    
                                    Button(action: {
                                        
                                        Task {
                                            await findAndShowPlayerDetails(name: lineup.lineup_player)
                                        }
                                    }) {
                                        let firstInitial = lineup.lineup_player.components(separatedBy: " ").first?.prefix(1) ?? ""
                                        let lastName = lineup.lineup_player.components(separatedBy: " ").last ?? ""
                                        let playerName = "\(firstInitial). \(lastName)"
                                        Text(playerName)
                                        Text(lineup.lineup_number)
                                            .font(.system(size: 15))
                                            .foregroundColor(.white)
                                    }
                                    
                                } //VSTACK
                            }//: ForEACH
                            
                            
                            
                        }// VSTACK
                        
                        .padding(.horizontal, 10)
                        
                        VStack(alignment: .leading) {
                            
                            ForEach(match.lineup.away.starting_lineups) { lineup in
                                VStack {
                                    Button(action: {
                                        print("Button tapped, attempting to load player details...")
                                        Task {
                                            await findAndShowPlayerDetails(name: lineup.lineup_player)
                                            
                                        }
                                    }) {
                                        Text(lineup.lineup_position)
                                            .font(.system(size: 15))
                                            .foregroundColor(.white)
                                        
                                        let firstInitial = lineup.lineup_player.components(separatedBy: " ").first?.prefix(1) ?? ""
                                        let lastName = lineup.lineup_player.components(separatedBy: " ").last ?? ""
                                        let playerName = "\(firstInitial). \(lastName)"
                                        Text(playerName)
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
                }// : HSTACK
                .frame(maxWidth:400)
                .foregroundStyle(.white)
                Spacer().frame(height:20)
                Text("STATISTICS")
                    .foregroundStyle(.white)
                    .font(Font.custom("Jomhuria", size: 50))
                HStack{
                    Text(match.match_hometeam_name).foregroundStyle(.white)
                    Spacer().frame(width:150)
                    Text(match.match_awayteam_name).foregroundStyle(.white)
                }//:HSTACK
                .frame(maxWidth:600)
                ForEach(match.statistics){stats in
                    if !stats.home.isEmpty && !stats.away.isEmpty {
                        VStack {
                            Text(stats.type).foregroundStyle(.white)
                            HStack {
                                Text(stats.home).foregroundStyle(.white)
                                Spacer().frame(width: 265)
                                Text(stats.away).foregroundStyle(.white)
                            }
                            Rectangle().frame(width: 500, height: 1).foregroundStyle(.white)
                        }//:VStack
                    }//:IF
                }//:ForEach
                
            }//:VSTACK
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.black)
            .cornerRadius(10)
            .padding()
        }
        
    } // :BODY
    
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
}

//MARK:PREVIEW

struct MatchDetailPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        MatchDetailPopUpView(league: LeaguesList.previewLeagues)
    }
}
