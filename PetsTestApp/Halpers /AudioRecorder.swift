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
    
    func startRecording() {
        // Check the current permission status for recording audio
        let permission = AVAudioApplication.shared.recordPermission
        
        switch permission {
        case .granted:
            // If permission is granted, start the actual recording process
            startActualRecording()
            
        case .denied:
            // If permission is denied, show an alert to inform the user
            showPermissionAlert = true
            
        case .undetermined:
            // If permission has not been determined, request permission from the user
            AVAudioApplication.requestRecordPermission { allowed in
                // On permission request completion, handle the result on the main thread
                DispatchQueue.main.async {
                    if allowed {
                        // If permission is granted, start the actual recording process
                        self.startActualRecording()
                    } else {
                        // If permission is denied, show an alert to inform the user
                        self.showPermissionAlert = true
                    }
                }
            }
            
        @unknown default:
            // In case of an unknown permission status, show an alert
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
