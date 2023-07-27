//
//  MovieCardView.swift
//  MovieFanPersistance
//
//  Created by Avinash Kumar on 27/07/23.
//

import SwiftUI

struct MovieCardView: View {
    
    var movie: Movie
    @ObservedObject var imageLoader = CacheNetworkImage()
    
    var body: some View {
        VStack {
            HStack {
                MovieBackdropCard(movie: movie).frame(width: 100, height: 50)
                Text(movie.title)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
            }
        }
        .padding()
    }
}

struct MovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView(movie: Movie.stubbedMovie)
    }
}
