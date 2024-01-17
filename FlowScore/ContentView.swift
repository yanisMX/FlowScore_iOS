//
//  ContentView.swift
//  FlowScore
//
//  Created by Yanis Mohamed on 17/01/2024.
//

import SwiftUI

struct ContentView: View {
    
    let backgroundBlack = Color.black
    
    var body: some View {
        HStack {
            VStack{
                Text("Flow Score")
                    .foregroundColor(Color.white)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 36))
            }
        }//Hstack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundBlack.ignoresSafeArea())
    }//:Body
}//:View

#Preview {
    ContentView()
}
