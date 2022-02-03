

import SwiftUI


import SwiftUI

struct PlayerListView: View {

    @ObservedObject private var viewModel = PlayerListViewModel()

    var body: some View {
        List(viewModel.players) { player in
            Text(player.firtsName)
            Text(player.lastName)
        }
    }

    init() {
        viewModel.fetchPlayers()
    }
}

struct PlayersListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView()
    }
}
