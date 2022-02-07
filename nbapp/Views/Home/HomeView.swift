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
    @ObservedObject var playerListViewModel: PlayerListViewModel
    
    init(viewModel: PlayerListViewModel = PlayerListViewModel()) {
        playerListViewModel = viewModel
        playerListViewModel.fetchPlayers()
    }
    
    var body: some View {
        NavigationView {
            PlayerListView(viewModel: playerListViewModel)
                .navigationTitle("Players")
                .toolbar {
                    Button(action: { playerListViewModel.fetchPlayers() },
                           label: { refreshImage })
                }
        }
        .sheet(isPresented: $state.showModal,
               onDismiss: nil) {
            Text("hello")
        }
               .environmentObject(state)
               .alert(isPresented: $playerListViewModel.showAlert) {
                   errorAlert
               }
    }
}

// MARK: - View Properties

extension HomeView {
    private var refreshImage: some View {
        Image(systemName: "arrow.clockwise.circle.fill")
            .foregroundColor(Color.primaryBlue)
    }
    
    private var errorAlert: Alert {
        Alert(title: Text("Error"),
              message: Text(playerListViewModel.errorDescription ?? ""),
              dismissButton: .default(Text("Ok")))
    }
}
