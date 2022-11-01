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
        Text("Hell World!")
      }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
      ProspectsView(filter: .none)
    }
}
