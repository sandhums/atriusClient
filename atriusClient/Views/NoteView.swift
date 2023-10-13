//
//  NoteView.swift
//  atriusClient
//
//  Created by Manjinder Sandhu on 13/10/23.
//

import SwiftUI
import AVFoundation

struct NoteView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
      @State private var isRecording = false
      
      var body: some View {
          VStack {
              Text(speechRecognizer.transcript)
                  .padding()
              
              Button(action: {
                  if !isRecording {
                      speechRecognizer.transcribe()
                  } else {
                      speechRecognizer.stopTranscribing()
                  }
                  
                  isRecording.toggle()
              }) {
                  Text(isRecording ? "Stop" : "Record")
                      .font(.title)
                      .foregroundColor(.white)
                      .padding()
                      .background(isRecording ? Color.red : Color.blue)
                      .cornerRadius(10)
              }
          }
      }
}

#Preview {
    NoteView()
      
}
