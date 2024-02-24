//
//  AI levels.swift
//  TicTacToe_v5_refactored
//
//  Created by Andrii Staryk on 22.12.2022.
//

import SwiftUI

struct AI_levels: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    
    var body: some View {
        
            ZStack{
                Background()
                VStack {
                    
                    Button {
                        viewModel.localization.language.ChangeLanguage()
                    } label: {
                        Text(viewModel.localization.language == .ukrainian ? "🇺🇦" : "🇬🇧")
                            .font(.largeTitle)
                    }
                    
                    Spacer()
                    
                    Button() {
                        viewModel.gameMode = .easyAI
                        viewModel.appState = .GameBoard
                        viewModel.player1.name = "You"
                        viewModel.player2.name = "EasyAI"
                    } label: {
                        Text("\(viewModel.localization.ailevels().easy)")
                            .modifier(ButtonStyle(viewModel: _viewModel))
                    }
                    
                    
                    Divider()
                        .frame(width: viewModel.screenWidth/1000)
                    
                    Button() {
                        viewModel.gameMode = .hardAI
                        viewModel.appState = .GameBoard
                        viewModel.player1.name = "You"
                        viewModel.player2.name = "HardAI"
                    } label: {
                        Text("\(viewModel.localization.ailevels().hard)")
                            .modifier(ButtonStyle(viewModel: _viewModel))
                    }
                    
                    Spacer()
                }
                .padding()
            }
    }
}

struct AI_levels_Previews: PreviewProvider {
    static var previews: some View {
        AI_levels()
            .environmentObject(GameViewModel())
    }
}
