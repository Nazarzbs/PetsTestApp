//
//  RecordingWaveView.swift
//  PetsTestApp
//
//  Created by Nazar on 26/4/25.
//

import SwiftUI

struct RecordingWaveView: View {
    @State private var barHeights: [CGFloat] = Array(repeating: 10, count: 25)

    var body: some View {
        HStack(spacing: 4) {
            ForEach(barHeights.indices, id: \.self) { index in
                Capsule()
                    .fill(Color.blue)
                    .frame(width: 2, height: barHeights[index])
            }
        }
        .frame(height: 70)
        .onAppear {
            // Timer to update bar heights periodically
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.2)) {
                    barHeights = barHeights.map { _ in
                        CGFloat.random(in: 4...30)  // Randomize height
                    }
                }
            }
        }
    }
}
