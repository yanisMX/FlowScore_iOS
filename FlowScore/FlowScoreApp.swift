//
//  FlowScoreApp.swift
//  FlowScore
//
//  Created by Yanis Mohamed on 17/01/2024.
//

import SwiftUI

@main
struct FlowScoreApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(countries: CountryList.previewCountry)
        }
    }
}
