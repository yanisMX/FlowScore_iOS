//
//  LoadingView.swift
//  FlowScore
//
//  Created by Yanis Mohamed on 26/02/2024.
//

import SwiftUI



struct LoadingView: View {
    var body: some View {
        HStack {
           
                Spacer()
                Text("tetst").foregroundColor(.purple)
            
                ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .red))
                .scaleEffect(3)
            
            
            
        }
        Color.black
        .ignoresSafeArea()
    }
}

#Preview {
    LoadingView()
}


