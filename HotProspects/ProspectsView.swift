//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Николай Никитин on 01.11.2022.
//

import CodeScanner
import SwiftUI

struct ProspectsView: View {

  enum FilterType {
    case none, contacted, uncontacted
  }

  @EnvironmentObject var prospects: Prospects
  @State private var isShowingScanner = false

  let filter: FilterType

  var title: String {
    switch filter {
    case .none:
      return "Everyone"
    case .contacted:
      return "Contacted People"
    case .uncontacted:
      return "Uncontacted"
    }
  }

  //MARK: - View body
  var body: some View {
    NavigationView {
      Text("People: \(prospects.people.count)")
        .navigationTitle(title)
        .toolbar {
          Button {
            isShowingScanner = true
          } label: {
            Label("Scan", systemImage: "qrcode.viewfinder")
          }
        }
        .sheet(isPresented: $isShowingScanner) {
          CodeScannerView(codeTypes: [.qr], simulatedData: "NikNikitin", completion: handleScanner)
        }
    }
  }

  //MARK: - View Methods
  func handleScanner(result: Result<ScanResult, ScanError>) {
    isShowingScanner = false
    switch result {
    case .success(let result):
      let details = result.string.components(separatedBy: "\n")
      guard details.count == 2 else { return }
      let person = Prospect()
      person.name = details[0]
      person.emailAddress = details[1]
      prospects.people.append(person)
    case .failure(let error):
      print("Scanning failed: \(error.localizedDescription)")
    }
  }
}

struct ProspectsView_Previews: PreviewProvider {
  static var previews: some View {
    ProspectsView(filter: .none)
      .environmentObject(Prospects())
  }
}
