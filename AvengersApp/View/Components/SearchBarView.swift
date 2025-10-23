//
//  SearchBarView.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 21/10/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
           HStack {
               TextField("search_placeholder", text: $searchText)
                   .padding(12)
                   .background(Color(.systemGray6))
                   .cornerRadius(8)
                   .overlay(
                       HStack {
                           Spacer()
                           if !searchText.isEmpty {
                               Button(action: {
                                   searchText = ""
                               }) {
                                   Image(systemName: "xmark.circle.fill")
                                       .foregroundColor(.gray)
                                       .padding(.trailing, 8)
                               }
                           }
                       }
                   )
           }
           .padding(.horizontal)
           .padding(.vertical, 8)
       }
}

#Preview {
    SearchBarView(searchText: .constant("dwdwdw"))
}
