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
                Text(player.playerName)
                    .foregroundColor(.white)
            } // VStack
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(backgroundBlack)
            .edgesIgnoringSafeArea(.all)
        } // NavStack
        .task {
            await playerModel.fetchDataPlayers(selectedPlayer: player.playerName)
        }
    } // Body
} // Entire View

// Preview
#Preview {
    DetailsPlayerView(player: PlayersList.previewPlayer)
}
