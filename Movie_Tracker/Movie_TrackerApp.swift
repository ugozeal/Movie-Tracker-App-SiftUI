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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
