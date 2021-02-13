//
//  MovieList.swift
//  Movie_Tracker
//
//  Created by David U. Okonkwo on 2/13/21.
//

import SwiftUI

struct MovieList: View {
    @EnvironmentObject var movieStorage: MovieStorage
    var body: some View {
        NavigationView {
            List(movieStorage.movies) { currentMoview in
                NavigationLink( destination: MovieDetailsView(movie: currentMoview, newMovie: false)) {
                    Text(currentMoview.title)
                }
            }.navigationTitle(Text("Movies"))
            .navigationBarItems(trailing: NavigationLink( destination: MovieDetailsView(movie: Movie(), newMovie: true)) {
                Image(systemName: "plus")
            })
        }
    }
}

struct MovieList_Previews: PreviewProvider {
    static var previews: some View {
        MovieList()
    }
}
