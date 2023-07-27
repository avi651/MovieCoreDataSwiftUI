//
//  MovieView.swift
//  MovieFanPersistance
//
//  Created by Avinash Kumar on 27/07/23.
//

import SwiftUI

struct MovieView: View {
    
    @StateObject var moviesViewModel = MoviesViewModel()
    
    var body: some View {
        List {
            Section(header: Text("Popular Movies")) {
                ForEach(moviesViewModel.movies) { movie in
                    NavigationLink(destination: DetailMovieView(movie: movie)) {
                        MovieCardView(movie: movie)
                    }
                }
            }
        }.navigationTitle("Movies").onAppear(){
            moviesViewModel.loadData()
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView()
    }
}
