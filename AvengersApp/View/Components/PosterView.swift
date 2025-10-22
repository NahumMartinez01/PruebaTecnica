//
//  PosterView.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 21/10/25.
//

import SwiftUI

struct PosterView: View {
    let imageUrl: String
    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(imageUrl)")) { image in
                image
                    .resizable()
                   // .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity,minHeight: 220, maxHeight: 220)
                    .clipped()
                    .cornerRadius(8)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 150, height: 220)
                    .cornerRadius(8)
                    .overlay {
                        ProgressView()
                    }
            }
        }
    }
}

#Preview {
    PosterView(imageUrl: "")
}
