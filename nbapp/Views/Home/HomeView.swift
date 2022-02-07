//
//  HomeView.swift
//  nbapp
//
//  Created by Merouane Bellaha on 03/02/2022.
//

import SwiftUI

class HomeViewState: ObservableObject {
    @Published var showModal = false
}

struct HomeView: View {
    
    @StateObject var state = HomeViewState()
    var playerListViewModel: PlayerListViewModel
    
    init(viewModel: PlayerListViewModel = PlayerListViewModel()) {
        playerListViewModel = viewModel
        playerListViewModel.fetchPlayers()
    }
    
    var body: some View {
        NavigationView {
            PlayerListView(viewModel: playerListViewModel)
                .navigationTitle("Players")
                .toolbar {
                    Button(action: {
                        playerListViewModel.fetchPlayers()
                    }, label: {
                        refreshImage
                    })
                }
        }
        .sheet(isPresented: $state.showModal,
               onDismiss: nil) {
            Text("hello")
        }
               .environmentObject(state)
    }
}

// MARK: - View Properties

extension HomeView {
    var refreshImage: some View {
        Image(systemName: "arrow.clockwise.circle.fill")
            .foregroundColor(Color.primaryBlue)
    }
}
