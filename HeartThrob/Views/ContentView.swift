//
//  ContentView.swift
//  HeartThrob
//
//  Created by David Doswell on 2/3/24.
//

import SwiftUI

struct ContentView: View {
  @AppStorage("home") var isHomeViewActive: Bool = true
  
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
