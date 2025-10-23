//
//  FavoritesView.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 22/10/25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var myAppManager: MyAppManager
    @Environment(\.dismiss) var dismiss
    @StateObject private var favoritesVM = FavoriteViewModel()
    @Binding var path: [HomeRoute]
    private let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
    var body: some View {
        ZStack {
            Color(.background).ignoresSafeArea()
            VStack {
                if favoritesVM.favorites.isEmpty {
                   EmptyDataView()
                }
                else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(favoritesVM.favorites) { movie in
                                CardItemsView(movie: movie,
                                              selectedLanguage: myAppManager.selectedLanguage,
                                              action: {path.append(.detail(movie: movie))})
                                                .accessibilityElement(children: .contain)
                                                .accessibilityIdentifier("MovieFavCell_\(movie.id)")
                            }
                        }
                        .padding()
                    }
                    
                }
            }
        }
        .scrollContentBackground(.hidden)
        .onAppear {
            favoritesVM.loadFavorites()
        }
        .navigationTitle("fav_title")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
            }
        }
    }
    
}

#Preview {
    FavoritesView(path: .constant([]))
}
