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
                .navigationTitle("pasteqa")
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
        HomeView()
                .previewDevice(PreviewDevice(rawValue: "iPod touch (7th generation)"))
    }
}

//no-commit
class HomeView_Preview: PreviewProvider {
    static var previews: some View {
        HomeView()
    }

    #if DEBUG
    @objc class func injected() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.first?.rootViewController =
                UIHostingController(rootView: HomeView())
    }
    #endif
}