//
//  MainTabView.swift
//  QuoteVault
//
//  Created by Nazmin Parween on 13/01/26.
//

import SwiftUI

struct MainTabView: View {

    var body: some View {
        TabView {

            NavigationStack {
                HomeView()
            }
            .tabItem {
                Image(systemName: "house.fill")
            }

            NavigationStack {
                SearchView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
            }

            NavigationStack {
                FavoritesView()
            }
            .tabItem {
                Image(systemName: "heart.fill")
            }

            NavigationStack {
                CollectionsView()
            }
            .tabItem {
                Image(systemName: "folder.fill")
            }
            
            NavigationStack {
                ProfileSettingsView()
            }
            .tabItem {
                Image(systemName: "person.circle")
            }
        }
    }
}



