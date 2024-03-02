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
                    .font(Font.custom("Inspiration", size: 50))
                    .offset(y:-300)
                if let url = URL(string: player.player_image), !player.player_image.isEmpty {
                               AsyncImage(url: url) { phase in
                                   switch phase {
                                   case .empty:
                                       ProgressView() // Affiche une vue de progression pendant le chargement de l'image.
                                   case .success(let image):
                                       image.resizable() // Rend l'image redimensionnable.
                                            .aspectRatio(contentMode: .fit) // Conserve les proportions de l'image.
                                            .frame(width: 300, height: 300) // Définit une taille pour l'image.
                                   case .failure:
                                       Image(systemName: "photo") // Affiche une image par défaut en cas d'échec du chargement.
                                           .foregroundColor(.gray)
                                           .frame(width: 300, height: 300) 
                                   @unknown default:
                                       EmptyView() // Gère les cas inconnus.
                                   }
                               }
                           } else {
                               Image(systemName: "photo") // Affiche une image par défaut si l'URL est vide ou invalide.
                                   .foregroundColor(.gray)
                           }
                
                
                
                
                Group {
                                      DetailView(title: "Age", value: player.player_age)
                                      DetailView(title: "Date de naissance", value: player.player_birthdate)
                                      DetailView(title: "Buts", value: player.player_goals)
                                      // Ajoutez plus de détails ici selon votre modèle
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
    }
}
// Preview
#Preview {
    DetailsPlayerView(player: PlayersList.previewPlayer)
}
