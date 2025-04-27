//
//  AudioRecorder.swift
//  PetsTestApp
//
//  Created by Nazar on 27/4/25.
//

import SwiftUI
import AVFoundation

// Observable class to handle audio recording functionality
@Observable
class AudioRecorder {
    var audioRecorder: AVAudioRecorder?   // Instance to handle the actual recording
    var isRecording = false               // Tracks recording state
    var showPermissionAlert = false       // Controls whether to show permission alert
    
    // Main function to initiate recording process
    func startRecording() {
        // Check current microphone permission status
        let permission = AVAudioSession.sharedInstance().recordPermission
        
        switch permission {
        case .granted:
            // Permission already granted, start recording immediately
            startActualRecording()
            
        case .denied:
            // User previously denied permission, show alert to direct to settings
            showPermissionAlert = true
            
        case .undetermined:
            // Permission not yet requested, ask for permission
            AVAudioSession.sharedInstance().requestRecordPermission { allowed in
                // Move back to main thread since UI updates must happen there
                DispatchQueue.main.async {
                    if allowed {
                        // User granted permission, start recording
                        self.startActualRecording()
                    } else {
                        // User denied permission, show alert
                        self.showPermissionAlert = true
                    }
                }
            }
            
        @unknown default:
            // Handle any future permission states Apple might add
            showPermissionAlert = true
        }
    }
    
    // Private method to set up and begin the actual recording process
    private func startActualRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            // Configure audio session for recording and playback
            // mixWithOthers allows other audio to continue playing during recording
            try recordingSession.setCategory(.playAndRecord, mode: .default, options: .mixWithOthers)
            try recordingSession.setActive(true)
            
            // Define where to save the recording
            let url = getDocumentsDirectory().appendingPathComponent("recording.m4a")
            
            // Configure audio recording settings
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),    // AAC format
                AVSampleRateKey: 12000,                      // Sample rate in Hz
                AVNumberOfChannelsKey: 1,                    // Mono recording
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue  // High quality
            ]
            
            // Initialize recorder with settings and start recording
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder?.record()
            isRecording = true
        } catch {
            // Handle any errors during recording setup
            print("Failed to start recording: \(error.localizedDescription)")
        }
    }
    
    // Helper method to get the app's documents directory for file storage
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
