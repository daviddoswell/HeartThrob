//
//  SessionListView.swift
//  HeartThrob
//
//  Created by David Doswell on 2/3/24.
//

import SwiftUI

struct SessionListView: View {
  @Environment(\.dismiss) var dismiss
  @ObservedObject var viewModel = SessionViewModel()
  
  var body: some View {
    NavigationView {
      ZStack {
        Color.colorBlue
          .ignoresSafeArea()
        
        // Conditional content based on session availability
        if viewModel.sessions.isEmpty {
          emptyStateView
        } else {
          sessionListView
        }
      }
      .navigationTitle("Sessions")
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          backButton // Custom back button
        }
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
  
  // Computed property for the custom back button
  private var backButton: some View {
    Button(action: {
      dismiss()
    }) {
      Image(systemName: "chevron.left")
        .foregroundColor(.white)
        .imageScale(.large)
    }
  }
  
  // Computed property for empty state view
  private var emptyStateView: some View {
    VStack {
      Spacer()
      Image(systemName: "heart.circle.fill")
        .resizable()
        .scaledToFit()
        .foregroundStyle(.white)
        .padding()
      Text("No sessions yet")
        .font(.system(size: 30.0, weight: .heavy, design: .rounded))
        .foregroundColor(.white)
        .padding(.bottom, 150)
      
      Spacer()
    }
    .background(Color.colorBlue)
  }
  
  // Computed property for session list view
  private var sessionListView: some View {
    List {
      ForEach(viewModel.sessions) { session in
        HStack {
          VStack(alignment: .leading) {
            Text(session.title)
              .font(.headline)
              .foregroundColor(.white)
            Text(session.description)
              .font(.subheadline)
              .foregroundColor(.white)
          }
          Spacer()
          Text(session.date.formatted(.dateTime.month().day().year().hour().minute()))
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.white)
        }
        .listRowBackground(Color.colorBlue)
      }
      .listRowSeparator(.hidden)
    }
    .listStyle(PlainListStyle())
  }
}

#Preview {
  SessionListView()
}
