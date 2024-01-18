//
//  ContentView.swift
//  FlowScore
//
//  Created by Yanis Mohamed on 17/01/2024.
//

import SwiftUI


extension Color {
    static var customBlue: Color{
        return Color(
            red : Double(0x11) / 255.0,
            green : Double(0x25) / 255.0,
            blue: Double(0xD8) / 255.0
        )
    }
}


struct CountryList: Codable, Identifiable {
    let country_id: Int
    let country_name: String
    let country_logo: String
    
    var id: Int {country_id}
    
}

extension CountryList {
    static let previewCountry:   [CountryList] = [
        CountryList(country_id: 1, country_name: "Espagne", country_logo: "espagne"),
        CountryList(country_id: 2, country_name: "Angleterre", country_logo: "angleterre"),
        CountryList(country_id: 3, country_name: "France", country_logo: "france"),
        CountryList(country_id: 5, country_name: "Italie", country_logo: "italie")]
}

struct ContentView: View {
//    MARK : PROPERTIES
    let countries : [CountryList]
    @State var IrishGrover = "IrishGrover-Regular";
    @State var Inspiration = "Inspiration-Regular";
    @State var Jomhuria = "Jomhuria-Regular";
    @State var Katibeh = "Katibeh-Regular";
    
    let columns: [GridItem] = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]

    
    let backgroundBlack = Color.black
    var GridItems : [GridItem] = Array(repeating: .init(), count: 1)
    
//    MARK : BODY
    var body: some View {
        VStack {
            Text("Select Country") .font(Font.custom("Inspiration", size:50))
                .foregroundColor(.white)
                .offset(y:-75)
        
            LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(countries) { country in
                                VStack {
                                    
                                    Image(country.country_logo)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .shadow(radius: 5)
                                        .frame(maxWidth: 100, maxHeight: 100)
                                    Text(country.country_name)
                                        .font(Font.custom("Jomhuria", size:50))
                                        .foregroundColor(.white)
                                        .offset(y:-20)
                                    Button(action: {}, label: {
                                        Text("Select")
                                            .font(Font.custom("Katibeh", size:25))
                                            .offset(y:5)
                                            .multilineTextAlignment(.center)
                                            .frame(width:100, height:30)
                                            .background(.white)
                                            .clipShape(Capsule())
                                            .foregroundColor(.black)
                                            
                                    })
                                    .offset(y:-50)
                                }
                            }
                        }
            
        }//VSTACK
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundBlack.ignoresSafeArea())
        
    }//:BODY
}//:VIEW

#Preview {
    ContentView(countries: CountryList.previewCountry)
}
