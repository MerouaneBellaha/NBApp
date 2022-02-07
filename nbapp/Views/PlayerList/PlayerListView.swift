

import SwiftUI


import SwiftUI

struct PlayerListView: View {
    
    @ObservedObject private var viewModel: PlayerListViewModel
    
    init(viewModel: PlayerListViewModel = PlayerListViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List {
            ForEach(viewModel.playersFirstLetters, id: \.self) { firstLetter in
                Section(header: Text(firstLetter.capitalized)) {
                    ForEach(viewModel.getPlayersForKey(firstLetter), id: \.id) { player in
                        PlayerCellView(playersFullName: (
                            firstName: player.firstName, lastName: player.lastName)
                        )
                    }
                }
                .font(.headline)
                .foregroundColor(Color.primaryBlue)
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct PlayersListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView(viewModel: PlayerListViewModel(players: Factory.createPlayersGroupedByFirstName()))
    }
}
