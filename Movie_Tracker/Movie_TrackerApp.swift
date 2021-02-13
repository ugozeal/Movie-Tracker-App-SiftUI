//
//  Movie_TrackerApp.swift
//  Movie_Tracker
//
//  Created by David U. Okonkwo on 2/12/21.
//

import SwiftUI

@main
struct Movie_TrackerApp: App {
    let persistenceController = PersistenceController.shared
    let movieStorage = MovieStorage()
    var body: some Scene {
        WindowGroup {
            MovieList()
                .environment(\.managedObjectContext, persistenceController.container.viewContext).environmentObject(movieStorage)
        }
    }
}
