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
  //MARK: - Class properties
  @Published private(set) var people: [Prospect]
  let saveKey = "SavedData"

  //MARK: - class init
  init() {
    if let data = UserDefaults.standard.data(forKey: saveKey) {
      if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
        people = decoded
        return
      }
    }
    people = []
  }

  //MARK: - Class methods
  private func save() {
    if let encoded = try? JSONEncoder().encode(people) {
      UserDefaults.standard.set(encoded, forKey: saveKey)
    }
  }

  func toggle(_ prospect: Prospect) {
    objectWillChange.send()
    prospect.isContacted.toggle()
    save()
  }

  func add(_ prospect: Prospect) {
    people.append(prospect)
    save()
  }
}
