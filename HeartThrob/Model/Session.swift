//
//  Session.swift
//  HeartThrob
//
//  Created by David Doswell on 2/3/24.
//

import Foundation

struct Session: Identifiable {
  
  // MARK: - PROPERTIES
  
  var id: String = UUID().uuidString
  var title: String
  var description: String = "You Found Yourself."
  var date: Date
}
