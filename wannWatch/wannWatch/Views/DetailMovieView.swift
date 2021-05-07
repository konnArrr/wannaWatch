//
//  DetailMovieView.swift
//  wannWatch
//
//  Created by Student on 05.05.21.
//

import SwiftUI


struct DetailMovieView: View {
    private let viewModel = DetailViewModel()
    let movie: Movie
    let showAddButton: Bool
    @State private var addButtonDisabled = false
    
    var body: some View {
        ScrollView {
            VStack {
                ImageWithURL(movie.posterURL.absoluteString)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250)
                    .padding(.vertical, 20)
                    // .frame(height: 100)
//                Spacer()
//                    .frame(height: 30)
                Text("\(movie.title)")
                    .font(Font.title.bold())
                    .padding(.horizontal, 30)
                Spacer()
                    .frame(height: 20)
                Text("\(movie.overview)")
                    .padding(.horizontal, 50)
            }
            .multilineTextAlignment(.center)
                .navigationTitle("Details")
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    HStack {
                        if showAddButton {
                            Button {
                                viewModel.saveMovieToFavourites(movie: movie)
                                addButtonDisabled = true
                            } label: {
                                Text("add to favourites")
                            }
                            .disabled(addButtonDisabled)
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
