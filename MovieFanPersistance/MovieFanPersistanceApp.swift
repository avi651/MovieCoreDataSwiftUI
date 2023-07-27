//
//  MovieFanPersistanceApp.swift
//  MovieFanPersistance
//
//  Created by Avinash Kumar on 27/07/23.
//

import SwiftUI

@main
struct MovieFanPersistanceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
