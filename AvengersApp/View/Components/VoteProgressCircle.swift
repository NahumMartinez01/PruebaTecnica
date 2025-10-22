//
//  VoteProgressCircle.swift
//  AvengersApp
//
//  Created by Nahum Martinez on 21/10/25.
//

import SwiftUI

struct VoteProgressCircle: View {
    let voteAverage: Double
    var progress: Double {
        min(max(voteAverage / 10, 0), 1)
    }

    var color: Color {
        switch voteAverage {
        case 7...10: return .green
        case 8..<9: return .orange
        case 5..<7: return .yellow
        default: return .red
        }
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 6)
                .opacity(0.2)
                .foregroundColor(color)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 0.6), value: progress)

            Text(String(format: "%.1f", voteAverage))
                .font(.caption)
                .bold()
                .foregroundColor(.white)
        }
        .frame(width: 50, height: 50)
        .background(.ultraThinMaterial)
        .clipShape(Circle())
    }
}

#Preview {
    VoteProgressCircle(voteAverage: 10.0)
}
