//
//  MoviesViewModel.swift
//  MovieFanPersistance
//
//  Created by Avinash Kumar on 27/07/23.
//

import Foundation
import Network
import CoreData

class MoviesViewModel: ObservableObject {
    
    private var networkConnectivity = NWPathMonitor()
    
    @Published var movies: [Movie] = [Movie]()
    @Published var state: FetchState = .good
    
    let service: APIServiceProtocol
    
    // Core Data
    var persistentController: MoviePersistentController
    
    init(apiService: APIServiceProtocol = APIService(),
         persistentController: MoviePersistentController = MoviePersistentController()) {
        self.service = apiService
        self.persistentController = persistentController
        networkConnectivity.start(queue: DispatchQueue.global(qos: .userInitiated))
    }
    
    internal func loadData() {
        fetchMovies()
    }
    
    private func fetchMovies() {
        switch networkConnectivity.currentPath.status {
              case .satisfied: // connected to internet
                 guard state == FetchState.good else {
                    return
                 }
                 
                 state = .isLoading
                 
                 service.fetchMovie { [weak self]  result in
                     DispatchQueue.main.async {
                         switch result {
                            case .success(let results):
                             
                             self?.movies = results.results
                             
                             if results.results.count == 0 {
                                 self?.state = .noResults
                                 self?.movies = (self?.persistentController.fetchMoviesFromCoreData())!
                             } else {
                                 self?.state = .good
                                 self?.persistentController.updateAndAddServerDataToCoreData(moviesFromBackend: self?.movies)
                             }
                             print("fetched movies \(results.results.count)")
                            case .failure(let error):
                             print("error loading movies: \(error)")
                             self?.state = .error(error.localizedDescription)
                             self?.movies = (self?.persistentController.fetchMoviesFromCoreData())!
                         }
                     }
                 }
            
              default:
                 print("Unable to fetch Data")
                 movies = persistentController.fetchMoviesFromCoreData() 
        }
        
    }
    
}
