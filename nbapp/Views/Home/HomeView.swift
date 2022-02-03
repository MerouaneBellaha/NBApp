//
//  HomeView.swift
//  nbapp
//
//  Created by Merouane Bellaha on 03/02/2022.
//

import SwiftUI

struct HomeView: View {

    var body: some View {
        NavigationView {
            ZStack {
                Color(.blue)
                    .edgesIgnoringSafeArea(.all)
                PlayerListView()
            }
            .navigationTitle("Players")
        }
    }
}
