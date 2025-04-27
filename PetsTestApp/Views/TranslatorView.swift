//
//  TranslatorView.swift
//  PetsTestApp
//
//  Created by Nazar on 26/4/25.
//

import SwiftUI
import AVFoundation

struct TranslatorView: View {
    // State properties to manage the translation mode, recording status, and selected pet
    @State private var translationMode: TranslationMode = .humanToPet
    @State private var isRecording = false
    @State private var showingResult = false
    @State private var translatedText = ["I’m hungry, feed me!", "What are you doing, human?"]
    @State private var petSelected: Pet = .cat
    @State private var processingTranslation = false
    
    // Audio recorder instance
    @State private var recorder = AudioRecorder()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient for a nice visual effect
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
                    // Show "Processing Translation" message if the translation is in progress
                    if processingTranslation {
                        Spacer()
                        Spacer()
                        HStack(spacing: 3) {
                            Text("Process of translation")
                                .textStyle(.body1())
                            ThreeDotsView(dotSize: 3, spasing: 5)
                                .offset(y: 3)
                        }
                    } else {
                        VStack {
                            // Title "Translator"
                            Text("Translator")
                                .textStyle(.heading1())
                                .bold()
                                .padding(.top, 20)
                            
                            // Mode toggle (Human <-> Pet)
                            HStack(spacing: 8) {
                                Text(translationMode == .humanToPet ? "HUMAN" : "PET")
                                    .textStyle(.body1())
                                    .frame(width: 135)
                                
                                // Toggle the translation direction when tapped
                                Image(.arrowSwapHorizontal)
                                    .onTapGesture {
                                        withAnimation {
                                            translationMode = translationMode == .humanToPet ? .petToHuman : .humanToPet
                                        }
                                    }
                                
                                Text(translationMode == .humanToPet ? "PET" : "HUMAN")
                                    .textStyle(.body1())
                                    .frame(width: 135)
                            }
                            
                            HStack(spacing: 35) {
                                // Recording button
                                Button(action: {
                                    // Start recording
                                    recorder.startRecording()
                                    if !recorder.showPermissionAlert {
                                        isRecording = true
                                        
                                        // Simulate a translation process after 4 seconds of recording
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                            processingTranslation = true
                                            isRecording = false
                                            
                                            // Show the result after 3 seconds
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                                processingTranslation = false
                                                showingResult = true
                                            }
                                        }
                                    }
                                }) {
                                    VStack(spacing: 24) {
                                        ZStack {
                                            // Show recording animation or microphone image based on recording state
                                            if isRecording {
                                                RecordingWaveView()
                                            } else {
                                                Image(.microphone)
                                                    .font(.system(size: 70))
                                                    .foregroundColor(.black)
                                            }
                                        }
                                        
                                        // Text showing the recording state
                                        Text(isRecording ? "Recording..." : "Start Speak")
                                            .textStyle(.body1())
                                            .foregroundColor(.black)
                                    }
                                    .frame(width: 178, height: 178, alignment: .center)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .shadow(radius: 5)
                                }
                                .disabled(isRecording)
                                
                                // Pet selection buttons
                                VStack {
                                    // Cat button
                                    Button(action: {
                                        petSelected = .cat
                                    }) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color(red: 209/255, green: 231/255, blue: 252/255))
                                                .frame(width: 70 , height: 70)
                                                .opacity(petSelected == .cat ? 1 : 0.6)
                                            
                                            Image(.cat)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 40 , height: 40)
                                                .opacity(petSelected == .cat ? 1 : 0.6)
                                            
                                            // Blur effect for selected pet
                                            if petSelected == .dog {
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color(red: 55/255, green: 62/255, blue: 125/255, opacity: 0.1))
                                                    .frame(width: 70, height: 70)
                                                    .blur(radius: 40)
                                            }
                                        }
                                    }
                                    .buttonStyle(.plain)
                                    
                                    // Dog button
                                    Button(action: {
                                        petSelected = .dog
                                    }) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color(red: 236/255, green: 251/255, blue: 199/255))
                                                .frame(width: 70 , height: 70)
                                                .opacity(petSelected == .dog ? 1 : 0.6)
                                            
                                            Image(.dog)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 40 , height: 40)
                                                .opacity(petSelected == .dog ? 1 : 0.6)
                                            
                                            // Blur effect for selected pet
                                            if petSelected == .cat {
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color(red: 55/255, green: 62/255, blue: 125/255, opacity: 0.1))
                                                    .frame(width: 70, height: 70)
                                                    .blur(radius: 40)
                                            }
                                        }
                                    }
                                    .buttonStyle(.plain)
                                }
                                .animation(.bouncy, value: petSelected)
                                .frame(width: 107 , height: 178, alignment: .center)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(radius: 5)
                            }
                            .padding(.top, 60)
                        }
                    }
                    
                    // Display the image of the selected pet
                    Image(petSelected == .cat ? .cat : .dog)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .padding(.top, 40)
                    
                    Spacer()
                }
                .animation(.smooth, value: processingTranslation)
            }
        }
        // Microphone permission alert
        .alert("Microphone Access Required", isPresented: $recorder.showPermissionAlert) {
                   Button("Cancel", role: .cancel) { }
                   Button("Settings") {
                       if let url = URL(string: UIApplication.openSettingsURLString) {
                           UIApplication.shared.open(url)
                       }
                   }
               } message: {
                   Text("Please allow microphone access in Settings to use the recording feature.")
               }
        // Show the result view when translation is done
        .sheet(isPresented: $showingResult) {
            ResultView(translatedText: translatedText.randomElement()!, pet: petSelected)
        }
    }
    
    // Enum to define the two translation modes
    enum TranslationMode {
        case humanToPet
        case petToHuman
    }
}

// Enum for pets
enum Pet {
    case dog
    case cat
}

#Preview {
    ContentView()
}
