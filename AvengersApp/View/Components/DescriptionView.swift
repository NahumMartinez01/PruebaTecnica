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
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Text(AppUtils.formattedDate(from: movieReleaseDate, languageCode: selectedLanguage).capitalized)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxHeight: 100,alignment: .top)
    }
}

#Preview {
    DescriptionView(title: "", movieReleaseDate: "", selectedLanguage: "")
}
