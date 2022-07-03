//
//  NavigationViewSearchView.swift
//  searchForBusinesses
//
//  Created by anupam mishra on 03/07/22.
//

import SwiftUI

struct NavigationViewSearchView: View {
    
    @Binding var businessName: String
    
    var body: some View {
        NavigationView {
            SearchView(businessName: .constant(businessName))
        }
    }
}

struct NavigationViewSearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationViewSearchView(businessName: .constant("Business"))
    }
}
