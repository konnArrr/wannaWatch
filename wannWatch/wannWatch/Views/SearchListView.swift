//
//  SearchListView.swift
//  wannWatch
//
//  Created by Student on 05.05.21.
//

import SwiftUI

struct SearchListView: View {
    @StateObject private var viewModel = SearchListViewModel()
    @State private var searchString: String = "Doom"
    @State private var showDetailView: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        TextField("search...", text: $searchString)
                            .disableAutocorrection(true)
                        Divider()
                    }
                    .padding(.horizontal, 20)
                    Button {
                        postSearchMsgToRepo()
                    } label: {
                        Image(systemName: "magnifyingglass.circle")
                            .font(Font.system(.largeTitle).bold())
                    }
                }
                .navigationTitle("Search")
                if !viewModel.searchedMoviesVm.isEmpty {
                    List {
                        ForEach(viewModel.searchedMoviesVm) {movie in
                            ZStack {
                                
                                Color.init(.sRGB, red: 0.6, green: 0.9, blue: 1.0, opacity: 0.5)
                                NavigationLink(destination: DetailMovieView(movie: movie, showAddButton: true)) {
                                    HStack {
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
                    }
                } else {
                    Spacer()
                    Text("Please enter\nnew search text")
                        .font(Font.system(.title))
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
        }
    }
    private func postSearchMsgToRepo() {
        NotificationCenter.default.post(name: .searchQueryMsg, object: searchString)
    }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView()
    }
}
