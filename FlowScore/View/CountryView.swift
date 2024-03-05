//
//  ContentView.swift
//  FlowScore
//
//  Created by Yanis Mohamed on 17/01/2024.
//

import SwiftUI

struct CountriesView: View {
    
    
//    MARK : PROPERTIES
    @StateObject var countriesModel = CountriesModel()
    @State var searchCountry = ""
    @State var selectedCountry = ""
    @State var isOn = false
    @StateObject var matchEventsModel = MatchEventsModel()
    let columns: [GridItem] = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]

    
    let backgroundBlack = Color.black
    var GridItems : [GridItem] = Array(repeating: .init(), count: 1)
    
//    MARK : BODY
    var body: some View {
            NavigationStack {
                VStack{
                // Header
                Text("Select Country")
                    .font(Font.custom("Inspiration", size: 50))
                    .foregroundColor(.white)
                    
                    TextField("Search country", text: $searchCountry)
                        .padding(10)
                        .background(Color(.white))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .offset(y:-10)
                //Liste pays
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(countriesModel.countries.filter{
                            country in searchCountry.isEmpty || country.country_name.localizedCaseInsensitiveContains(searchCountry)
                        }) { country in
                            VStack {
                                AsyncImage(url: URL(string: country.country_logo)){
                                    logo in logo.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .aspectRatio(contentMode: .fit)
                                .shadow(radius: 5)
                                .frame(maxWidth: 100, maxHeight: 100)
                                
                                Text(country.country_name)
                                    .font(Font.custom("Jomhuria", size: 50))
                                    .foregroundColor(.white)
                                    .offset(y: -20)
                                
                                
                                //Bouton select country
                                NavigationLink(destination: LeagueView(country:country)){
                                    Text("Select")
                                        .font(Font.custom("Katibeh", size: 25))
                                        .offset(y: 5)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 100, height: 30)
                                        .background(Color.white)
                                        .clipShape(Capsule())
                                        .foregroundColor(.black)
                                }
                                .offset(y: -50)
                            } // :VStack
                            .padding(5)
                            
                        }// :ForEach
                    }// :LazyVGrid
                }// :ScrollView
                }// :VStack
                .background(backgroundBlack)
            }// : NavigationStack
            
            .task {
                await countriesModel.fetchDataCountries()
            } // : task

    }
}//:VIEW



#Preview {
    CountriesView()
}

