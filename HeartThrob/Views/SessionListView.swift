//
//  SessionListView.swift
//  HeartThrob
//
//  Created by David Doswell on 2/3/24.
//

import SwiftUI

struct SessionListView: View {
  @Environment(\.dismiss) private var dismiss
  @ObservedObject var viewModel = SessionViewModel()
  
  var body: some View {
    ZStack {
      Color.colorBlue
        .ignoresSafeArea()
      
      NavigationView {
        List {
          ForEach(viewModel.sessions) { session in
            HStack {
              VStack(alignment: .leading) {
                Text(session.title)
                  .font(.headline)
                  .foregroundStyle(.white)
                Text(session.description)
                  .font(.subheadline)
                  .foregroundStyle(.white)
              }
              Spacer()
              Text(session.date.formatted(.dateTime.month().day().year().hour().minute()))
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white)
            }
          }
          .background(.colorBlue)
          .listRowBackground(Color.colorBlue)
          .listRowSeparator(.hidden)
        }
        .onAppear() {
          viewModel.fetchSessions()
        }
        .navigationTitle("Sessions")
        .navigationBarBackButtonHidden(true)
        .background(.colorBlue)
        .listStyle(PlainListStyle())
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
              dismiss()
            }) {
              Image(systemName: "chevron.left")
                .foregroundColor(.white)
                .imageScale(.large)
            }
          }
        }
        .background(Color.colorBlue)
      }
      .padding()
      .navigationViewStyle(StackNavigationViewStyle())
    }
  }
}

#Preview {
  SessionListView()
}
