//
//  ToastMessage.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 22/10/25.
//

import SwiftUI

struct ToastMessage: View {
    let message: String
    var body: some View {
        VStack {
                Text(message)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color(.toastBg))
                    .cornerRadius(12)
                    .foregroundColor(.white)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .zIndex(1)

        }
        .frame(maxWidth: .infinity, alignment: .bottom)
    }
}

#Preview {
    ToastMessage(message: "Hello World")
}
