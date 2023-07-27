//
//  DetailMovieView.swift
//  MovieFanPersistance
//
//  Created by Avinash Kumar on 27/07/23.
//

import SwiftUI

struct DetailMovieView: View {
    
    var movie: Movie
    @ObservedObject var imageLoader = CacheNetworkImage()
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            MovieBackdropCard(movie: movie).frame(width: 200, height: 200)
            Text(movie.title).font(.title).fontWeight(.bold).padding(.horizontal)
            }
            
        }
}

struct DetailMovieView_Previews: PreviewProvider {
    static var previews: some View {
        DetailMovieView(movie: Movie.stubbedMovie)
    }
}
