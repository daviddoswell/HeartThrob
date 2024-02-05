//
//  ContentView.swift
//  HeartThrob
//
//  Created by David Doswell on 2/3/24.
//

import SwiftUI

struct ContentView: View {
  
  // MARK: - PROPERTIES
  @AppStorage("home") var isHomeViewActive: Bool = true
  
  // MARK: - BODY
  var body: some View {
    ZStack {
      if isHomeViewActive {
        HomeView()
      } else {
        MeditationView()
      }
    }
  }
}

#Preview {
  ContentView()
}

