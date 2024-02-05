//
//  LaunchScreenView.swift
//  HeartThrob
//
//  Created by David Doswell on 2/3/24.
//

import SwiftUI

struct LaunchScreenView: View {
  @Binding var isActive: Bool
  @State private var scale: CGFloat = 1.0
  var body: some View {
    ZStack {
      Color.colorBlue
        .ignoresSafeArea()
      
      Image("character-2")
        .resizable()
        .scaledToFit()
        .opacity(0.5)
      
      Image("logo")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundStyle(.white)
        .scaleEffect(scale)
        .frame(width: 100.0, height: 100.0)
        .onAppear {
          withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
            self.scale = 1.2
          }
          
          // Delay transition
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
              self.isActive = false
            }
          }
        }
    }
  }
}


#Preview {
  LaunchScreenView(isActive: .constant(true))
}
