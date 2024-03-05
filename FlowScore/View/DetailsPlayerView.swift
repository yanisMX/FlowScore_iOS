//
//  DetailsPlayerView.swift
//  FlowScore
//
//  Created by Yanis Mohamed on 28/02/2024.
//

import SwiftUI

struct DetailsPlayerView: View {
    // MARK: - PROPERTIES
    
    @StateObject var playerModel = PlayerModel()
    let backgroundBlack = Color.black
    let player : PlayersList
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack {
            
                Text(player.player_name)
                    .foregroundColor(.white)
                    .bold()
                    .font(Font.custom("", size: 50))
                    .offset(y:-10)
                
                if let url = URL(string: player.player_image), !player.player_image.isEmpty {
                               AsyncImage(url: url) { phase in
                                   switch phase {
                                   case .empty:
                                       ProgressView() // Affiche une vue de progression pendant le chargement de l'image.
                                   case .success(let image):
                                       image.resizable() // Rend l'image redimensionnable.
                                            .aspectRatio(contentMode: .fit) // Conserve les proportions de l'image.
                                            .frame(width: 250, height: 250) // Définit une taille pour l'image.
                                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                   case .failure:
                                       Image("profile") // Affiche une image par défaut en cas d'échec du chargement.
                                           .aspectRatio(contentMode: .fit) // Conserve les proportions de l'image.
                                           .frame(width: 350, height: 350) // Définit une taille pour l'image.
                                           .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                           
                                   @unknown default:
                                       EmptyView() // Gère les cas inconnus.
                                   }
                               }
                           } else {
                               Image("profile") // Affiche une image par défaut en cas d'échec du chargement.
                                   .aspectRatio(contentMode: .fit) // Conserve les proportions de l'image.
                                   .frame(width: 350, height: 350) // Définit une taille pour l'image.
                                   .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                           }
                
               
                
                Group {
                                      DetailView(title: "Age", value: player.player_age)
                                      DetailView(title: "Birthday", value: player.player_birthdate)
                                      DetailView(title: "Position", value: player.player_type)
                                        Text("Saison")
                                           .font(.headline)
                                           .foregroundColor(.white)
                                           .frame(maxWidth: .infinity, alignment: .leading)
                                           .padding(.vertical)
                                           .padding(.leading, 16)
                                      DetailView(title: "Goals", value: player.player_goals)
                                      DetailView(title: "Average mark per match", value: player.player_rating)
                                      DetailView(title: "Team", value: player.team_name)
                                      DetailView(title: "Match played", value: player.player_match_played)
                                      DetailView(title: "Minutes played", value: player.player_minutes)
                                  }

            } // VStack
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundBlack)
            .edgesIgnoringSafeArea(.all)
        } // NavStack
        .task {
            await playerModel.fetchDataPlayers(selectedPlayer: player.player_name)
        }
    } // Body
} // Entire View
struct DetailView: View {
    var title: String
    var value: String

    var body: some View {
        HStack {
            Text(title + ":")
                .font(.headline)
                .foregroundColor(.gray)
            Text(value)
                .font(.title2)
                .foregroundColor(.white)
            Spacer()
        }
        .padding(.leading, 16)
        
    }
}
// Preview
#Preview {
    DetailsPlayerView(player: PlayersList.previewPlayer)
}

