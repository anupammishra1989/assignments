//
//  Utilities.swift
//  searchForBusinesses
//
//  Created by anupam mishra on 02/07/22.
//

import Foundation
import SwiftUI

class Utilities {
    ///Open url link in external browser
    static func openWebPage(from urlString: String?) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
                  print("Invalid url")
                  return
              }
        UIApplication.shared.open(url)
    }
}
