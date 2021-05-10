//
//  FavouriteMoviesView.swift
//  wannWatch
//
//  Created by Student on 06.05.21.
//

import SwiftUI

struct FavouriteMoviesView: View {
    @StateObject private var viewModel = FavouritesViewModel()
    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.favouriteMoviesVm.isEmpty {
                    List {
                        ForEach(viewModel.favouriteMoviesVm) { movie in
                            ZStack {
                                Color.init(.sRGB, red: 1, green: 0.4, blue: 0, opacity: 0.5)
                                NavigationLink(destination: DetailMovieView(movie: movie, showAddButton: false)) {
                                    HStack {
                                        Image(systemName: "hand.thumbsup.fill")
                                        Spacer()
                                        Text(movie.title)
                                            .multilineTextAlignment(.center)
                                        Spacer()
                                    }
                                }                                
                                .padding()
                                .border(Color.black, width: 2)
                            }
                        }
                        .onDelete(perform: delete)
                        .onMove(perform: move)
                    }
                    // .onDelete(perform: delete)
                } else {
                    Spacer()
                    Text("No favourites yet")
                        .font(Font.system(.title))
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
            .navigationTitle("Favourites")
            .toolbar {
                EditButton()
            }
        }
        
    }
    private func delete(at offsets: IndexSet) {
        viewModel.deleteFromFavouriteList(at: offsets)
    }
    private func move(from source: IndexSet, to destination: Int) {
        viewModel.moveFavouriteList(from: source, to: destination)
    }
}

struct FavouriteMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteMoviesView()
    }
}
