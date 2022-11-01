//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Николай Никитин on 01.11.2022.
//

import SwiftUI

struct ProspectsView: View {

  enum FilterType {
    case none, contacted, uncontacted
  }

  @EnvironmentObject var prospects: Prospects

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
              let prospect = Prospect()
              prospect.name = "Nik Nikitin"
              prospect.emailAddress = "nikitin.nikolay.v@gmail.com"
              prospects.people.append(prospect)
            } label: {
              Label("Scan", systemImage: "qrcode.viewfinder")
            }
          }
      }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
      ProspectsView(filter: .none)
    }
}
