//
//  TabBarView.swift
//  InvestingApp
//
//  Created by Praval Gautam on 12/10/24.
//
import SwiftUI

struct TabBarView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.black
    }
    var body: some View {

        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                        .foregroundStyle(.white)
                }
            
            HomeView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Favorite")
                        .foregroundStyle(.white)
                }
            
            HomeView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Chat")
                        .foregroundStyle(.white)
                }
            
            HomeView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                        .foregroundStyle(.white)
                }
                .accentColor(.gray)
        }
        .accentColor(.white)
        .onAppear {
                    UITabBar.appearance().unselectedItemTintColor = UIColor.gray
                }
    }
}

#Preview {
    TabBarView()
}

