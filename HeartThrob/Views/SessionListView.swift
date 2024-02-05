//
//  SessionListView.swift
//  HeartThrob
//
//  Created by David Doswell on 2/3/24.
//

import SwiftUI

struct SessionListView: View {
  
  // MARK: - PROPERTIES
  
  @Environment(\.dismiss) var dismiss
  @ObservedObject var viewModel = SessionViewModel()
  
  // MARK: - BODY
  
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
      } //: ZSTACK
      .navigationTitle("Sessions")
      .navigationBarBackButtonHidden(true)
      .onAppear {
        viewModel.fetchSessions()
      }
      
      // MARK: - TOOLBAR
      
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          backButton
        }
      } //: TOOLBAR
    } //: NAVIGATION STACK
    .navigationViewStyle(StackNavigationViewStyle())
  }
  
  // MARK: - FUNCTIONS
  
  private var backButton: some View {
    
    // MARK: - CUSTOM BACK BUTTON

    Button(action: {
      dismiss()
    }) {
      Image(systemName: "chevron.left")
        .foregroundColor(.white)
        .imageScale(.large)
    } //: BUTTON
  }
  
  // MARK: - EMPTY STATE

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
    } //: VSTACK
    .background(Color.colorBlue)
  }
  
  // MARK: - SESSION LIST VIEW
  
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
          } //: VSTACK
          Spacer()
          Text(session.date.formatted(.dateTime.month().day().year().hour().minute()))
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.white)
        } //: HSTACK
        .listRowBackground(Color.colorBlue)
      } //: FOR EACH
      .listRowSeparator(.hidden)
    } //: LIST
    .listStyle(PlainListStyle())
  }
}

#Preview {
  SessionListView()
}
