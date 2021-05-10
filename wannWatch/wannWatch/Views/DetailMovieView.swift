//
//  DetailMovieView.swift
//  wannWatch
//
//  Created by Student on 05.05.21.
//

import SwiftUI


struct DetailMovieView: View {
    private let viewModel = DetailViewModel()
    let movie: Watchable
    let showAddButton: Bool
    @State private var addButtonDisabled = false
    
    var userRating: String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        let rate = movie.voteAverage * 10
        return formatter.string(from: NSNumber(value: rate)) ?? "0%"
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ImageWithURL(movie.posterURL.absoluteString)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                    .padding(.vertical, 20)
                Text("\(movie.title)")
                    .font(Font.title.bold())
                    .padding(.horizontal, 30)
                Spacer()
                    .frame(height: 20)
                Text("\(movie.releaseDate)")
                Spacer()
                    .frame(height: 20)
                Text("\(movie.overview)")
                    .padding(.horizontal, 50)
                Spacer()
                    .frame(height: 30)
                Text("User Rating:\n\(userRating)%")
                    .font(Font.system(.title2))
                Spacer()
                    .frame(height: 50)
            }
            .multilineTextAlignment(.center)
            .navigationTitle("Details")
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    HStack {
                        if !viewModel.favouritesListContains(movie) {
                            Button {
                                viewModel.saveMovieToFavourites(movie: movie)
                                addButtonDisabled = true
                            } label: {
                                Text("add to favourites")
                            }
                            .disabled(addButtonDisabled)
                        } else {
                            Image(systemName: "heart.fill")
                        }
                    }
                }
            }
        }
    }    
}

//struct DetailMovieView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailMovieView()
//    }
//}
