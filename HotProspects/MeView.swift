//
//  MeView.swift
//  HotProspects
//
//  Created by Николай Никитин on 01.11.2022.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct MeView: View {

//MARK: - View Properties
  @State private var name = "Anon"
  @State private var emailAddress = "anon@nodomen.com"
  let context = CIContext()
  let filter = CIFilter.qrCodeGenerator()

  //MARK: - View Body
    var body: some View {
      NavigationView {
        Form {
          TextField("Name", text: $name)
            .textContentType(.name)
            .font(.title)

          TextField("Email Address", text: $emailAddress)
            .textContentType(.emailAddress)
            .font(.title)

          Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
            .resizable()
            .interpolation(.none)
            .scaledToFit()
            .frame(width: 200, height: 200)
        }
      }
    }

  //MARK: - View Methods
  func generateQRCode(from string: String) -> UIImage {
    filter.message = Data(string.utf8)
    if let outputImage = filter.outputImage {
      if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
        return UIImage(cgImage: cgImg)
      }
    }
    return UIImage(systemName: "xmark.circle") ?? UIImage()
  }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
