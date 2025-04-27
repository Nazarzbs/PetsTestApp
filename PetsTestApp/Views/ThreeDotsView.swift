//
//  ThreeDotsView.swift
//  PetsTestApp
//
//  Created by Nazar on 26/4/25.
//

import SwiftUI

struct ThreeDotsView: View {
    @State var loading = false  // Controls the animation state
    var dotSize: CGFloat  // Dot size
    var spasing: CGFloat  // Space between dots
    
    var body: some View {
        HStack(spacing: spasing) {
            // Dot 1
            Circle()
                .fill(Color.black)
                .frame(width: dotSize, height: dotSize)
                .scaleEffect(loading ? 1.5 : 0.5)
                .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: loading)
            
            // Dot 2 with delay
            Circle()
                .fill(Color.black)
                .frame(width: dotSize, height: dotSize)
                .scaleEffect(loading ? 1.5 : 0.5)
                .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true).delay(0.2), value: loading)
            
            // Dot 3 with delay
            Circle()
                .fill(Color.black)
                .frame(width: dotSize, height: dotSize)
                .scaleEffect(loading ? 1.5 : 0.5)
                .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true).delay(0.4), value: loading)
        }
        .onAppear {
            self.loading = true  // Start animation when the view appears
        }
    }
}
