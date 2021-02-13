//
//  MovieModel.swift
//  Movie_Tracker
//
//  Created by David U. Okonkwo on 2/13/21.
//

import Foundation

struct Movie: Identifiable {
    var id = UUID()
     var title = ""
    var rating = 3.0
    var seen = false
}

class MovieStorage: ObservableObject {
    @Published var movies = [Movie]()
}
