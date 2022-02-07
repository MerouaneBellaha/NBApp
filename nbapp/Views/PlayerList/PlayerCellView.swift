//
//  PlayerCellView.swift
//  nbapp
//
//  Created by Merouane Bellaha on 03/02/2022.
//

import SwiftUI

struct PlayerCellView: View {
    
    @EnvironmentObject var state: HomeViewState
    
    var playersFullName: (firstName: String, lastName: String)
    
    var body: some View {
        HStack(spacing: 5) {
            Text(playersFullName.firstName)
            Text(playersFullName.lastName)
                .font(.body)
        }
        .listRowBackground(Color.lightBrown)
        .onTapGesture {
            state.showModal.toggle()
        }
    }
}

struct PlayerCellView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerCellView(playersFullName: (firstName: "Kobe", lastName: "Bryant"))
    }
}
