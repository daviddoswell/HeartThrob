//
//  MeditationView.swift
//  HeartThrob
//
//  Created by David Doswell on 2/3/24.
//

import SwiftUI
import AVFoundation

struct MeditationView: View {
  // MARK: - PROPERTY
  @AppStorage("home") var isHomeViewActive: Bool = false
  @State private var isAnimating: Bool = false
  @State private var navigationPath = NavigationPath()
  @State private var showShareSheet: Bool = false
  @State private var remainingTime = 60
  @State private var timer: Timer?
  
  @ObservedObject var sessionViewModel = SessionViewModel()
  
  // MARK: - FUNCTIONS
  func startTimer() {
    remainingTime = 60 // Reset timer to 60 seconds for a fresh start
    timer?.invalidate() // Invalidate any existing timer
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
      if remainingTime > 0 {
        remainingTime -= 1
      } else {
        timerDidEnd()
      }
    }
  }
  
  func timerDidEnd() {
    timer?.invalidate()
    timer = nil // Clear the timer
    showShareSheet = true // Show the share sheet
  }
  
  func endSession() {
    let newSession = Session(
      title: "Session \(sessionViewModel.sessions.count + 1)",
      date: Date()
    )
    sessionViewModel.addSession(session: newSession)
  }
  
  // MARK: - BODY
  var body: some View {
    NavigationStack(path: $navigationPath) {
      VStack(spacing: 20) {
        Spacer()
        ZStack {
          CircleGroupView(shapeColor: .gray, shapeOpacity: 0.1)
          Image("character-2")
            .resizable()
            .scaledToFit()
            .padding()
            .offset(y: isAnimating ? 35 : -35)
          // Apply continuous animation here
            .onAppear {
              withAnimation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                isAnimating.toggle()
              }
            }
        }
        
        if timer != nil {
          Text("\(remainingTime) seconds")
            .font(.system(size: 50.0, design: .rounded))
            .fontWeight(.bold)
            .transition(.opacity)
        }
        
        Spacer()
        
        Button(action: {
          playSound(sound: "meditate", type: "mp3")
          startTimer()
        }) {
          Image(systemName: "heart.circle.fill")
            .imageScale(.large)
          Text("Find Yourself")
            .font(.system(.title3, design: .rounded))
            .fontWeight(.bold)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .shadow(radius: 2)
        
        Button(action: {
          playSound(sound: "sessions", type: "mp3")
          navigationPath.append("SessionListView")
        }) {
          HStack {
            Image(systemName: "list.bullet.circle.fill")
              .imageScale(.large)
              .foregroundStyle(.white)
            Text("Sessions List")
              .foregroundStyle(.white)
              .font(.system(.title3, design: .rounded))
              .fontWeight(.bold)
          }
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .shadow(radius: 2)
        
        Button(action: {
          playSound(sound: "home", type: "mp3")
          isHomeViewActive = true
        }) {
          Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
            .imageScale(.large)
          Text("Return Home")
            .font(.system(.title3, design: .rounded))
            .fontWeight(.bold)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .controlSize(.large)
        .shadow(radius: 2)
      }
      .sheet(isPresented: $showShareSheet) {
        VStack {
          Text("Congratulations on finding a moment of peace.")
            .font(.system(size: 30.0, design: .rounded))
            .fontWeight(.bold)
            .multilineTextAlignment(.center)
            .padding()
          
          Button("Dismiss") {
            playSound(sound: "harp", type: "mp3")
            endSession()
            showShareSheet = false
          }
          .font(.system(.title3, design: .rounded))
          .fontWeight(.bold)
          .buttonStyle(.borderedProminent)
          .buttonBorderShape(.capsule)
          .controlSize(.large)
          .padding()
        }
      }
      .navigationDestination(for: String.self) { destination in
        if destination == "SessionListView" {
          SessionListView(viewModel: sessionViewModel)
            .navigationBarBackButtonHidden(true)
        }
      }
    }
  }
}

#Preview {
  MeditationView()
}
