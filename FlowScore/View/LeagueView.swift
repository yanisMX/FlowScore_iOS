//
//  CountryView.swift
//  FlowScore
//
//  Created by Yanis Mohamed on 17/01/2024.
//

import SwiftUI

struct CountryView: View {
    var body: some View {
                    
        
        VStack {
            Text("Mettre nom du pays")
                .font(Font.custom("Jomhuria", size:50))
                .foregroundColor(.white)
                .offset(y:-275)
                
            Text("Select Country") .font(Font.custom("Inspiration", size:50))
                .foregroundColor(.white)
                .offset(y:-275)
            
            
            
            
            
        }//Vstack
        
        
        
        
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .ignoresSafeArea()
    }//:BODY
        
}//: VIEW
#Preview {
    CountryView()
}
