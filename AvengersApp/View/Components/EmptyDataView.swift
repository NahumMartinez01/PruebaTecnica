//
//  EmptyView.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 22/10/25.
//

import SwiftUI

struct EmptyDataView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Image(systemName: "square.stack.3d.down.forward")
                    .font(.system(size: 50))
                    .foregroundStyle(.white)
                Text("No hay datos disponibles")
                    .foregroundStyle(.white)
            }
            .padding()
            Spacer()
        }
        
    }
}

#Preview {
    EmptyDataView()
}
