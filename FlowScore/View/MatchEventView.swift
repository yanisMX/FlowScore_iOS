//  MatchEventView.swift
//  FlowScore
//
//  Created by SDV Bordeaux on 18/01/2024.
//

import SwiftUI

struct MatchEventView: View {
    
    @StateObject var matchesModel = MatchEventsModel()
    @StateObject var countriesModel = CountriesModel()
    @StateObject var leaguesModel = LeaguesModel()
    @State private var isShowingDetailsSheet = false
    @State private var isLoading = false
    @State private var isDetailsPlayerViewPresented = false
    @State private var selectedPlayerDetails: PlayersList?
    @State private var selectedMatch: MatchEventList?
    @StateObject var playerModel = PlayerModel()
    
    
    let league: LeaguesList
    let backgroundBlack = Color.black
    
    
    var body: some View {
        NavigationStack {
            VStack {
                //Header
                Text("Matchs du jour")
                    .font(Font.custom("Inspiration", size: 50))
                    .foregroundColor(.white)
                
                ScrollView {
                    ForEach(matchesModel.matches,id:\.match_id) {match in
                        VStack {
                            DisclosureGroup {
                                VStack{
                                    VStack {
                                        //récupération des buteurs
                                        let allScorers = match.goalscorer.filter { $0.home_scorer != "" || $0.away_scorer != "" }
                                        let sortedScorers = allScorers.sorted { $0.time < $1.time }
                                        //boucle buteur
                                        ForEach(sortedScorers, id: \.id) { scorer in
                                            if scorer.home_scorer != "" {
                                                HStack {
                                                    Text("\(scorer.time)'")
                                                    Text("\(scorer.home_scorer)")
                                                    Text("(\(match.match_hometeam_name))")
                                                    Spacer()
                                                }//:HsTACK
                                            } else {
                                                HStack {
                                                    Spacer()
                                                    Text("\(scorer.away_scorer)")
                                                    Text("(\(match.match_awayteam_name))")
                                                    Text("\(scorer.time)'")
                                                }//:HStack
                                            }//:else
                                        }//:Foreach
                                        .foregroundColor(.blue)
                                    }//:VStack
                                    
                                    // Hstack
                                    
                                    Button(action: {
                                        isShowingDetailsSheet = true
                                        self.selectedMatch = match
                                    }) {
                                        
                                        //bouton pour ouvrir le popuover
                                        Text("Voir + de détails")
                                            .font(.system(size: 15))
                                            .multilineTextAlignment(.center)
                                            .frame(width: 200, height: 20)
                                            .background(Color.blue)
                                            .clipShape(Capsule())
                                            .foregroundColor(.white)
                                    }
                                    .sheet(isPresented: $isShowingDetailsSheet) {
                                        // Assurez-vous que `selectedMatch` n'est pas nil avant d'essayer de présenter MatchDetailsSheetView
                                        Text("Test")
                                    }
                                    
                                    .popover(isPresented: $isShowingDetailsSheet, content: {
                                        ScrollView{
                                            VStack{
                                                Spacer().frame(height:20)
                                                HStack{
                                                    // Affichage du nom de l'équipe à domicile et de son score
                                                    AsyncImage(url: URL(string: match.team_home_badge))
                                                    {
                                                        image in image.resizable()
                                                    } placeholder: {
                                                        ProgressView()
                                                    } .frame(maxWidth: 50, maxHeight: 50)
                                                    
                                                    Text(match.match_hometeam_name + " " + match.match_hometeam_score)
                                                        .foregroundColor(.white)
                                                        .fontWeight(.bold)
                                                        .font(.system(size: 18))
                                                    Text(" - ")
                                                    // Affichage du nom de l'équipe à l'extérieur et de son score
                                                    Text(match.match_awayteam_score + " " + match.match_awayteam_name)
                                                        .foregroundColor(.white)
                                                        .fontWeight(.bold)
                                                        .font(.system(size: 18))
                                                    
                                                    AsyncImage(url: URL(string: match.team_away_badge))
                                                    {
                                                        image in image.resizable()
                                                    } placeholder: {
                                                        ProgressView()
                                                    } .frame(maxWidth: 50, maxHeight: 50)
                                                }
                                                
                                                //header popup
                                                Text("Referee: " + match.match_referee).foregroundStyle(.white)
                                                Text("Stadium : " + match.match_stadium).foregroundStyle(.white)
                                                Spacer().frame(height:20)
                                                Text("LINEUPS").foregroundStyle(.white)
                                                    .font(Font.custom("Jomhuria", size: 50))
                                                Spacer().frame(height:100)
                                                ZStack{
                                                    Image("footballfield")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .rotationEffect(.degrees(90))
                                                    
                                                    
                                                    //bandeau pour nom gardien domicile + son nom
                                                    ZStack{
                                                        Rectangle().frame(width: 40,height:10).foregroundStyle(.black).offset(y:-160)
                                                        ForEach(match.lineup.home.starting_lineups) { lineup in
                                                            if lineup.lineup_position == "1" {
                                                                Text(lineup.lineup_player).foregroundStyle(.white).offset(y:-160).font(.system(size: 5))
                                                            }//:If
                                                            
                                                        }//:ForEach
                                                    }
                                                    Image("mailotdom")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width:25,height:25)
                                                        .offset(y:-180)
                                                    
                                                    
                                                    //bandeau pour nom gardien exterieur + son nom
                                                    ZStack{
                                                        Rectangle().frame(width: 40,height:10).foregroundStyle(.black).offset(y:180)
                                                        ForEach(match.lineup.away.starting_lineups) { lineup in
                                                            if lineup.lineup_position == "1" {
                                                                Text(lineup.lineup_player).foregroundStyle(.white).offset(y:180).font(.system(size: 5))
                                                            }//:If
                                                            
                                                        }//:ForEach
                                                    }
                                                    Image("maillotext")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width:25,height:25)
                                                        .offset(y:160)
                                                    
                                                    //parse des compos grace a la fonction parseFormation
                                                    
                                                    let defendersHOME = parseFormation(formation: match.match_hometeam_system).defenders
                                                    let midfieldersHOME = parseFormation(formation:match.match_hometeam_system).midfielders
                                                    let attackershome = parseFormation(formation: match.match_hometeam_system).attackers
                                                    
                                                    let defendersAWAY = parseFormation(formation: match.match_awayteam_system).defenders
                                                    let midfieldersAWAY = parseFormation(formation: match.match_awayteam_system).midfielders
                                                    let attackersAWAY = parseFormation(formation: match.match_awayteam_system).attackers
                                                    
                                                    // affichage des maillots defenseurs domiciles + leurs nom (pas finaliser)
                                                    ForEach(0..<defendersHOME, id: \.self) { index in
                                                        ZStack {
                                                            Image("mailotdom")
                                                                .resizable()
                                                                .aspectRatio(contentMode: .fit)
                                                                .frame(width: 25, height: 25)
                                                            // Calculer et appliquer offset
                                                                .offset(x: CGFloat(index - defendersHOME/2) * 50, y: -140)
                                                            Rectangle()
                                                                .frame(width: 40, height: 10)
                                                                .foregroundColor(.black)
                                                                .offset(x: CGFloat(index - defendersHOME/2) * 50, y: -120)
                                                            
                                                            
                                                            ForEach(match.lineup.home.starting_lineups) { lineup in
                                                                if lineup.lineup_position == "\(index + 1)" {
                                                                    Text(lineup.lineup_player)
                                                                        .foregroundColor(.white)
                                                                        .offset(y: -120)
                                                                        .font(.system(size: 5))
                                                                }//:if
                                                            }//:ForEach
                                                            
                                                        }//:ZStack
                                                        
                                                    }//:ForEach
                                                    
                                                    
                                                    // boucles pour tout les autres joeueurs
                                                    
                                                    
                                                    ForEach(0..<midfieldersHOME,id:\.self){ index in
                                                        Image("mailotdom")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 25, height: 25)
                                                        // Calculer et appliquer offset
                                                            .offset(x: CGFloat(index - midfieldersHOME/2) * 50, y: -90)
                                                    }//:ForEach
                                                    
                                                    ForEach(0..<attackershome,id:\.self){ index in
                                                        Image("mailotdom")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 25, height: 25)
                                                        // Calculer et appliquer offset
                                                            .offset(x: CGFloat(index - attackershome/2) * 50, y: -30)
                                                    }//:ForEach
                                                    
                                                    ForEach(0..<defendersAWAY, id: \.self) { index in
                                                        Image("maillotext")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 25, height: 25)
                                                        // Calculer et appliquer offset
                                                            .offset(x: CGFloat(index - defendersAWAY/2) * 50, y: 140)
                                                    }//:ForEach
                                                    
                                                    ForEach(0..<midfieldersAWAY,id:\.self){ index in
                                                        Image("maillotext")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 25, height: 25)
                                                        // Calculer et appliquer offset
                                                            .offset(x: CGFloat(index - midfieldersAWAY/2) * 50, y: 90)
                                                    }//:ForEach
                                                    
                                                    ForEach(0..<attackersAWAY,id:\.self){ index in
                                                        Image("maillotext")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 25, height: 25)
                                                        // Calculer et appliquer offset
                                                            .offset(x: CGFloat(index - attackersAWAY/2) * 50, y: 30)
                                                    }//:ForEach
                                                    
                                                }//:ZStack
                                                
                                                Spacer().frame(height:100)
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
                                                                    // nom des joueurs au format P.Nom
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
                                                        if !match.lineup.away.starting_lineups.isEmpty && !match.lineup.home.starting_lineups.isEmpty{
                                                            ForEach(match.lineup.away.starting_lineups) { lineup in
                                                                VStack {
                                                                    // nom des joueurs cliquable pour acceder a leur detail
                                                                    Button(action: {
                                                                        print("Button tapped, attempting to load player details...")
                                                                        Task {
                                                                            await findAndShowPlayerDetails(name: lineup.lineup_player)
                                                                            
                                                                        }//:Task
                                                                    }) {
                                                                        Text(lineup.lineup_number)
                                                                            .font(.system(size: 15))
                                                                            .foregroundColor(.white)
                                                                        // nom des joueurs au format P.Nom
                                                                        let firstInitial = lineup.lineup_player.components(separatedBy: " ").first?.prefix(1) ?? ""
                                                                        let lastName = lineup.lineup_player.components(separatedBy: " ").last ?? ""
                                                                        let playerName = "\(firstInitial). \(lastName)"
                                                                        Text(playerName)
                                                                    }
                                                                    .sheet(isPresented: $isDetailsPlayerViewPresented) {
                                                                       
                                                                        if let playerDetails = selectedPlayerDetails {
                                                                            DetailsPlayerView(player: playerDetails)
                                                                        }
                                                                    }    //:if
                                                                    
                                                                }
                                                            }//:ForEach
                                                            
                                                        }else {
                                                            //si pas de compos dans l'api
                                                            Text("No informations")
                                                        }
                                                        
                                                    }
                                                }
                                                .padding(.horizontal, 10)
                                            }// : HSTACK
                                            .frame(maxWidth:400)
                                            .foregroundStyle(.white)
                                            Spacer().frame(height:20)
                                            
                                            //partie stats
                                            Text("STATISTICS")
                                                .foregroundStyle(.white)
                                                .font(Font.custom("Jomhuria", size: 50))
                                            HStack{
                                                Text(match.match_hometeam_name).foregroundStyle(.white)
                                                Spacer().frame(width:150)
                                                Text(match.match_awayteam_name).foregroundStyle(.white)
                                            }//:HSTACK
                                            .frame(maxWidth:600)
                                            if
                                                match.statistics.isEmpty{
                                                Spacer().frame(height:20)
                                                Text("Match not started").foregroundStyle(.white)
                                            }//:if
                                            else
                                            {
                                                ForEach(match.statistics) { stats in
                                                    if let homeValue = Double(stats.home), let awayValue = Double(stats.away) {
                                                        let baseTotalValue = max(homeValue + awayValue, 1)
                                                        let totalValue = stats.type == "Substitution" ? 5 : max(baseTotalValue, 1) // si la stats est remplacement max 5
                                                        Text(stats.type)
                                                            .foregroundStyle(.white)
                                                        HStack {
                                                            VStack {
                                                                Text(stats.home).foregroundStyle(.white)
                                                                ProgressView(value: homeValue, total:totalValue)
                                                                    .frame(width: 200, height: 5)
                                                                    .tint(homeValue > awayValue ? Color.blue : Color.gray)
                                                                    .background(Color.gray.opacity(0.3)) // Arrière-plan pour montrer la progression même à 0
                                                            }
                                                            VStack {
                                                                Text(stats.away).foregroundStyle(.white)
                                                                ProgressView(value: awayValue, total: totalValue)
                                                                    .frame(width: 200, height: 5) // Hauteur définie pour visibilité
                                                                    .rotationEffect(.degrees(180)) // Rotation pour inverser la direction
                                                                    .tint(awayValue > homeValue ? Color.blue : Color.gray)
                                                                    .background(Color.gray.opacity(0.3)) // Arrière-plan pour visibilité à 0
                                                            }//:VStack
                                                        }//:HStack
                                                        .frame(maxWidth: .infinity)
                                                    }//:If
                                                }//:ForEach
                                                
                                            }//:else
                                            
                                        }//:VSTACK
                                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                        .background(Color.black)
                                        .cornerRadius(10)
                                        .padding()
                                    })
                                    
                                } // :VSTACK
                            }  //popover
                            
                            
                            
                        label: {
                            HStack {
                                VStack {
                                    Text(
                                        match.match_live == "1" ?
                                        match.match_status + "'" :
                                            // si match fini
                                            (match.match_time < getCurrentTime() ? "Finished" : match.match_time)                                     ).foregroundStyle(Color.white)
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
    
    //fonction pour raffraichir au scroll vers le bas
    func fetchData() async {
        isLoading = true
        await matchesModel.fetchDataMatchs(selectedLeague: league.league_id)
        isLoading = false
        print("Data refreshed")
    }
    
    //récupérer la date du jour
    func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: Date())
    }
    
    
    //fonction pour récupérer les détails des joueurs en fonction de leur nom
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
    
    // fonction pour récupérer le nombre de défenseurs, milieux,attaquants
    func parseFormation(formation: String) -> (defenders: Int, midfielders: Int, attackers: Int) {
        let parts = formation.split(separator: "-").map { Int($0) } // Convertir en tableau d'Int optionnels
        guard parts.count >= 3 else { return (0, 0, 0) } // Vérifier que la formation est valide
        
        let defenders = parts[0] ?? 0
        let attackers = parts[parts.count - 1] ?? 0
        
        // Somme des milieux (tous les éléments sauf le premier et le dernier)
        let midfielders = parts[1..<parts.count - 1].reduce(0) { $0 + ($1 ?? 0) }
        
        return (defenders, midfielders, attackers)
    }
    
    
}//Body



// MARK: PREVIEW
struct MatchEventView_Previews: PreviewProvider {
    static var previews: some View {
        MatchEventView(league: LeaguesList.previewLeagues)
    }
}
