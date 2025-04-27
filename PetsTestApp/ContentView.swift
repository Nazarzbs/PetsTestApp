//
//  ContentView.swift
//  PetsTestApp
//
//  Created by Nazar on 24/4/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0  // Track the selected tab index
    
    var body: some View {
        ZStack {
            // Background gradient for a nice visual effect
            LinearGradient(
                colors: [
                    Color(red: 201/255, green: 255/255, blue: 224/255)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Show the selected view based on the selected tab index
                Group {
                    if selectedTab == 0 {
                        TranslatorView()  // Show the TranslatorView when the 0th tab is selected
                    } else {
                        ClickerView()  // Show the ClickerView when the 1st tab is selected
                    }
                }
                
                customTabBar  // Custom tab bar at the bottom
            }
        }
        .ignoresSafeArea()  // Make the entire screen area covered by the gradient background
    }
    
    // Custom tab bar view
    private var customTabBar: some View {
        ZStack {
            // Background of the tab bar with rounded corners
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .frame(width: 216, height: 82)
                .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 4)
               
            // Tab items inside the tab bar
            HStack(spacing: 50) {
                tabBarItem(icon: .messages2, title: "Translator", tag: 0)  // Tab item for Translator
                tabBarItem(systemIcon: "gearshape", title: "Clicker", tag: 1)  // Tab item for Clicker
            }
            .padding(.horizontal, 30)
        }
        .padding(.bottom, 40)  // Bottom padding to place it above the device's safe area
    }
    
    // Tab bar item for custom icon (non-system image)
    @ViewBuilder
    private func tabBarItem(icon: ImageResource, title: String, tag: Int) -> some View {
        Button {
            selectedTab = tag  // Set the selected tab when this item is tapped
        } label: {
            VStack(spacing: 8) {
                Image(icon)  // Display the custom image for the tab
                    .renderingMode(.template)  // Use template mode to apply foreground color
                    .foregroundColor(selectedTab == tag ? .black : .gray)  // Change color based on selection
                Text(title)  // Display the title of the tab
                    .textStyle(.body2())  // Use custom body text style
                    .foregroundColor(selectedTab == tag ? .black : .gray)  // Change text color based on selection
            }
        }
    }
    
    // Tab bar item for system icon (using SF Symbols)
    @ViewBuilder
    private func tabBarItem(systemIcon: String, title: String, tag: Int) -> some View {
        Button {
            selectedTab = tag  // Set the selected tab when this item is tapped
        } label: {
            VStack(spacing: 8) {
                Image(systemName: systemIcon)  // Display the system icon (SF Symbols)
                    .font(.system(size: 24))  // Adjust the size of the system icon
                    .foregroundColor(selectedTab == tag ? .black : .gray)  // Change color based on selection
                Text(title)  // Display the title of the tab
                    .textStyle(.body2())  // Use custom body text style
                    .foregroundColor(selectedTab == tag ? .black : .gray)  // Change text color based on selection
            }
        }
    }
}

#Preview {
    ContentView()  // Show the preview of ContentView
}
