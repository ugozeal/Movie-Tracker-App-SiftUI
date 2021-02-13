//
//  MovieDetailsView.swift
//  Movie_Tracker
//
//  Created by David U. Okonkwo on 2/12/21.
//

import SwiftUI
import CoreData

struct MovieDetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var movie: Movie
    @Environment(\.presentationMode) var presentationMode
    let newMovie: Bool
    @EnvironmentObject var movieStorage: MovieStorage

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        List {
            Section {
                SectionTitle(title: "Title")
                TextField("Movie title", text: $movie.title)
            }
            Section {
                SectionTitle(title: "Rating")
                HStack {
                    Spacer()
                    Text(String(repeating: "★", count: Int(movie.rating)))
                        .foregroundColor(.yellow).font(.title)
                        .accessibility(label: Text("\(Int(movie.rating)) star rating"))
                    Spacer()
                }
                Slider(value: $movie.rating, in: 1...5, step: 1)
                    .accessibility(label: Text("\(Int(movie.rating)) star rating"))
            }
            Section {
                SectionTitle(title: "Seen")
                Toggle(isOn: self.$movie.seen){
                    if movie.title == "" {
                        Text("I have seen this movie")
                    } else {
                        Text("I have seen \(movie.title)")
                    }
                }
            }
            Section {
                Button(action: {
                    if self.newMovie {
                        self.movieStorage.movies.append(self.movie)
                    } else {
                        for x in 0..<self.movieStorage.movies.count {
                            if self.movieStorage.movies[x].id == self.movie.id {
                                self.movieStorage.movies[x] = self.movie
                            }
                        }
                    }
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Spacer()
                        Text("Save")
                        Spacer()
                    }
                }.disabled(movie.title.isEmpty)
            }
        }.listStyle(GroupedListStyle())
//        List {
//            ForEach(items) { item in
//                Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//            }
//            .onDelete(perform: deleteItems)
//        }
//        .toolbar {
//            #if os(iOS)
//            EditButton()
//            #endif
//
//            Button(action: addItem) {
//                Label("Add Item", systemImage: "plus")
//            }
//        }
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(movie: Movie(), newMovie: false).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct SectionTitle: View {
    var title: String
    var body: some View {
        Text(title).font(.caption).foregroundColor(.gray)
    }
}
