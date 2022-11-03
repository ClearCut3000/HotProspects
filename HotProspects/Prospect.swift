//
//  Prospect.swift
//  HotProspects
//
//  Created by Николай Никитин on 01.11.2022.
//

import Foundation

class Prospect: Identifiable, Codable {

  var id = UUID()
  var name = "Anonymous"
  var emailAddress = ""
  fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
  @Published var people: [Prospect]

  init() {
    people = []
  }

  func toggle(_ prospect: Prospect) {
    objectWillChange.send()
    prospect.isContacted.toggle()
  }
}
