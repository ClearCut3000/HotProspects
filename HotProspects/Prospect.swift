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
  let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData")


  //MARK: - class init
  init() {
    if let data = try? Data(contentsOf: savePath) {
      if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
        people = decoded
        return
      }
    }
    // if no saved data!
    people = []
  }

  //MARK: - Class methods
  private func save() {
    if let encoded = try? JSONEncoder().encode(people) {
      try? encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
    }
  }

  func toggle(_ prospect: Prospect) {
    objectWillChange.send()
    prospect.isContacted.toggle()
    save()
  }

  func delete(_ prospect: Prospect) {
    if let index = people.firstIndex(where: { man in
      man.name == prospect.name && man.emailAddress == prospect.emailAddress
    }) {
      people.remove(at: index)
      save()
    }
  }

  func add(_ prospect: Prospect) {
    if !people.contains(where: { man in
      man.name == prospect.name && man.emailAddress == prospect.emailAddress
    }) {
      people.append(prospect)
      save()
    }
  }
}
