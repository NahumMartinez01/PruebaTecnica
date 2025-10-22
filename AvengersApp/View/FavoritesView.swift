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
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        ZStack {
            Color(red: 15/255, green: 15/255, blue: 25/255).ignoresSafeArea()
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(favoritesVM.favorites) { movie in
                        CardItemsView(movie: movie,
                                      selectedLanguage: myAppManager.selectedLanguage,
                                      action: {path.append(.detail(movie: movie))})
                    }
                }
                .padding()
            }
        }
        .scrollContentBackground(.hidden)
        .onAppear {
            favoritesVM.loadFavorites()
        }
        .navigationTitle("Mis Favoritos")
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
