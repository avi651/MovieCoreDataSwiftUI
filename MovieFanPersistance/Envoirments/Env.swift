//
//  Env.swift
//  MovieFanPersistance
//
//  Created by Avinash Kumar on 27/07/23.
//

import Foundation

enum Env {

    private static let infoDict: [String:Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist is not found")
        }
        return dict
    }()

    static let rootURL: URL = {
        guard let urlString = Env.infoDict["Root_URL"] as? String else {
            fatalError("Root URL is not found")
        }

        guard let url = URL(string: urlString) else {
            fatalError("Root URL is invalid")
        }

        return url

    }()

}
