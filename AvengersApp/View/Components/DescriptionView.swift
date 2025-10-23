//
//  DescriptionView.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 21/10/25.
//

import SwiftUI

struct DescriptionView: View {
    let title: String
    let movieReleaseDate: String
    let selectedLanguage: String
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Text(AppUtils.formattedDate(from: movieReleaseDate, languageCode: selectedLanguage).capitalized)
                .font(.subheadline)
                .foregroundColor(Color.white.opacity(0.7))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxHeight: 100,alignment: .top)
        .padding(.horizontal, 4)
        .padding(.vertical, 4)
    }
}

#Preview {
    DescriptionView(title: "", movieReleaseDate: "", selectedLanguage: "")
}
