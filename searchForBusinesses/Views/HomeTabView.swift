//
//  HomeTabView.swift
//  searchForBusinesses
//
//  Created by anupam mishra on 26/06/22.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {
        TabView {
            HomeView().tabItem {
                Label("Home", systemImage: "house.fill")
            }
            NavigationViewSearchView(businessName: .constant("Business")).tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
