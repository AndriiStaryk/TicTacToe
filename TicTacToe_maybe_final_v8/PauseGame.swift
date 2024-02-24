//
//  PauseGame.swift
//  TicTacToe_v5_refactored
//
//  Created by Andrey Starik on 11.01.2023.
//

import SwiftUI

struct PauseGame: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    
    @State private var offsetY = -500.0
    
    var body: some View {
        
            VStack {
               
                Button {
                    //viewModel.appState = .GameBoard
                    viewModel.continueGame()
                } label: {
                    
                    Text(viewModel.localization.pauseGameButtons().resumeGame)
                        .modifier(ButtonStyle(viewModel: _viewModel))
                }
                
                
                Divider()
                    .frame(width: viewModel.screenWidth/1000)
                
                Button {
                    viewModel.resetGame()
                    viewModel.appState = .GameBoard
                } label: {
                    Text(viewModel.localization.pauseGameButtons().restartGame)
                        .modifier(ButtonStyle(viewModel: _viewModel))

                }
                
                Divider()
                    .frame(width: viewModel.screenWidth/1000)
                
                
                Button {
                    viewModel.resetGame()
                    viewModel.appState = .Menu
                } label: {
                    Text(viewModel.localization.pauseGameButtons().toMainMenu)
                        .modifier(ButtonStyle(viewModel: _viewModel))
                }
                
            }.padding(.horizontal)
        .frame(width: viewModel.screenWidth/1.1, height: viewModel.screenWidth/1.1)
        .offset(y: offsetY)
        .onAppear {
            withAnimation(.easeIn(duration: 0.25)) {
                self.offsetY = 0
            }
        }
    }
}

struct PauseGame_Previews: PreviewProvider {
    static var previews: some View {
        PauseGame()
            .environmentObject(GameViewModel())
    }
}
