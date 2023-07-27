//
//  APIServiceProtocol.swift
//  MovieFanPersistance
//
//  Created by Avinash Kumar on 27/07/23.
//

import Foundation

protocol APIServiceProtocol {
    func fetchMovie(completion: @escaping(Result<MovieResult, APIError>) -> Void)
}
