//
//  ResultView.swift
//  PetsTestApp
//
//  Created by Nazar on 26/4/25.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.dismiss) private var dismiss  // Dismiss the view
    let translatedText: String  // The translated text to display
    let pet: Pet  // The selected pet (cat or dog)
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [
                        Color(red: 243/255, green: 245/255, blue: 246/255),
                        Color(red: 201/255, green: 255/255, blue: 224/255)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                VStack {
                    // Close button and title
                    ZStack {
                        HStack {
                            Button(action: { dismiss() }) {  // Close the view
                                ZStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 48, height: 48)
                                    
                                    Image(.xmark)  // Close icon
                                        .foregroundColor(.primary)
                                }
                            }
                            Spacer()
                        }
                        
                        Text("Result")  // Title text
                            .textStyle(.heading1())
                            .bold()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    
                    Spacer()
                    
                    // Conditional result view (either a text bubble or repeat button)
                    if Bool.random() {
                        ZStack {
                            Image(.textBubble)  // Text bubble background
                                .resizable()
                                .scaledToFit()
                                .frame(height: 250)
                                .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 4)
                            Text(translatedText)  // Display translated text
                                .textStyle(.body2())
                                .offset(y: -50)  // Position the text inside the bubble
                        }
                    } else {
                        Button(action: { dismiss() }) {  // Repeat button
                            ZStack {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color(red: 214/255, green: 220/255, blue: 255/255))
                                    .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 4)
                                    .frame(width: 290, height: 54)
                                
                                HStack {
                                    Image(.rotateRight)  // Icon for the repeat action
                                    Text("Repeat")  // Button text
                                        .textStyle(.body2())
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    // Display the pet image (dog or cat)
                    Image(pet == .dog ? .dog : .cat)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .padding(.bottom, 150)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
