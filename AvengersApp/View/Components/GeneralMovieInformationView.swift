//
//  GeneralMovieInformation.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 22/10/25.
//

import SwiftUI

struct GeneralMovieInformationView: View {
    let title: String
    let overview: String
    let date: String
    let voteAverage: Double
    let selectedLanguage: String
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 8) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(AppUtils.formattedDate(from: date, languageCode: selectedLanguage).capitalized)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white.opacity(0.7))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack(alignment: .center){
                VoteProgressCircle(voteAverage: voteAverage)
                
                Text("Puntuación de usuarios")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white.opacity(0.85))
                    .frame(maxWidth: 90, alignment: .leading)
                Spacer()
            }
            
            VStack(spacing: 4) {
                Text("Sinopsis:")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white.opacity(0.95))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(overview)
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(Color.white.opacity(0.85))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    GeneralMovieInformationView(title: "dwdwdw", overview: "dwdwdw", date: "dwdwdwdw", voteAverage: 2.0,selectedLanguage: "")
}
