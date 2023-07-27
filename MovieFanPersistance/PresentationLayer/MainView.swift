//
//  ContentView.swift
//  MovieFanPersistance
//
//  Created by Avinash Kumar on 27/07/23.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        
        TabView{
            MovieView()
                .tabItem {
                    VStack {
                        Image(systemName: "tv")
                        Text("Movies")
                    }
            }.tag(0)
            
            RatingView()
                .tabItem {
                    VStack {
                        Image(systemName: "chart.bar")
                        Text("Ratings")
                    }
            }.tag(1)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
