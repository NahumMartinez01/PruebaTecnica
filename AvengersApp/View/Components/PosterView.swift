//
//  PosterView.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 21/10/25.
//

import SwiftUI

struct PosterView: View {
    let imageUrl: String
    let height: CGFloat
    let rounded: CGFloat
    
    init(imageUrl: String, height: CGFloat = 200, rounded: CGFloat = 8) {
        self.imageUrl = imageUrl
        self.height = height
        self.rounded = rounded
    }
    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(imageUrl)")) { image in
                image
                    .resizable()
                    .frame(maxWidth: .infinity,minHeight: height, maxHeight: height)
                    .clipped()
                    .cornerRadius(rounded)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(maxWidth: .infinity,minHeight: height, maxHeight: height)
                    .cornerRadius(rounded)
                    .overlay {
                        ProgressView()
                    }
            }
        }
    }
}

#Preview {
    PosterView(imageUrl: "", height: 200, rounded: 0)
}
