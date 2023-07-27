//
//  MoviePersistentController.swift
//  MovieFanPersistance
//
//  Created by Avinash Kumar on 27/07/23.
//

import Foundation
import CoreData

class MoviePersistentController: ObservableObject {
    var persistentContainer = NSPersistentContainer(name: "MovieFanPersistance")
    private var moviesFetchRequest = MovieCD.fetchRequest()
    
    init() {
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("error = \(error)")
            }
        }
    }
    
    func updateAndAddServerDataToCoreData(moviesFromBackend: [Movie]?) {
        // 0. prepare incoming server side movies ID list and dictionary
        var moviesIdDict: [Int: Movie] = [:]
        var moviesIdList: [Int] = []
        
        guard let movies = moviesFromBackend,
              !movies.isEmpty else {
            return
        }
        
        for movie in movies {
            moviesIdDict[movie.id] = movie
        }
        moviesIdList = movies.map { $0.id }
        
        // 1. get all movies that match incoming server side movie ids
        // find any existing movies in our local CoreData
        moviesFetchRequest.predicate = NSPredicate(
            format: "id IN %@", moviesIdList
        )
        
        // 2. make a fetch request using predicate
        let managedObjectContext = persistentContainer.viewContext
        
        let moviesCDList = try? managedObjectContext.fetch(moviesFetchRequest)
        print("moviesCDList = \(String(describing: moviesCDList))")
        
        guard let moviesCDList = moviesCDList else {
            return
        }
        
        var moviesIdListInCD: [Int] = []
        
        // 3. update all matching movies from CoreData to have the same data
        // server side movies
        for movieCD in moviesCDList {
            moviesIdListInCD.append(Int(movieCD.id))
            
            if let movie = moviesIdDict[Int(movieCD.id)] {
                movieCD.setValue(movie.overview,
                                 forKey: "overview")
                movieCD.setValue(movie.title,
                                 forKey: "title")
                movieCD.setValue(movie.posterPath,
                                 forKey: "imageUrlSuffix")
                movieCD.setValue(movie.releaseDate,
                                 forKey: "releaseDate")
            }
        }
        
        // 4. add new objects coming from the backend/server side
        for movie in movies {
            if !moviesIdListInCD.contains(movie.id) {
                let genreCD = GenreCD(context: managedObjectContext)
                genreCD.id = 1
                genreCD.title = "Comedy"
                
                let movieCD = MovieCD(context: managedObjectContext)
                movieCD.id = Int64(movie.id)
                movieCD.overview = movie.overview
                movieCD.releaseDate = movie.releaseDate
                movieCD.imageUrlSuffix = movie.posterPath
                movieCD.genre = genreCD
            }
        }
        
        // 5. save changes
        try? managedObjectContext.save()
    }
    
    func fetchMoviesFromCoreData() -> [Movie] {
        
        let movieTitleSortDescriptor = NSSortDescriptor(key: "title",
                                                   ascending: false)
        let movieReleaseDateSortDescriptor = NSSortDescriptor(key: "imageUrlSuffix", ascending: true)
        moviesFetchRequest.sortDescriptors = [movieReleaseDateSortDescriptor]
        
        
        let moviesCDList = try? persistentContainer.viewContext.fetch(moviesFetchRequest)
        var convertedMovies: [Movie] = []
        
        guard let moviesCDList = moviesCDList else {
            return []
        }
        
        for movieCD in moviesCDList {
            let movie = Movie(adult: false, backDropPath: "", id: Int(movieCD.id), originalLanguage: "", originalTitle: "", overview: movieCD.overview ?? "", popularity: 0.0, posterPath:  movieCD.imageUrlSuffix ?? "", releaseDate: movieCD.releaseDate ?? "", title: movieCD.title ?? "", video: false, voteAverage: 0.0, voteCount: 0.0)
            convertedMovies.append(movie)
        }
        
        return convertedMovies
    }
    
}
