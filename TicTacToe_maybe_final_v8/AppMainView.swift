//
//  AppMainView.swift
//  TicTacToe_maybe_final_v8
//
//  Created by Andrey Starik on 14.01.2023.
//

import SwiftUI

struct AppMainView: View {
    
    @StateObject var viewModel: GameViewModel = GameViewModel()
    
    var body: some View {
        switch viewModel.appState {
        case .Loading:
            LoadingView()
                .environmentObject(viewModel)
            
        case .Menu:
            MainMenu()
                .environmentObject(viewModel)
           
        case .AiLevels:
            AI_levels()
                .environmentObject(viewModel)
            
        case .HumansSetup:
            HumansSetupView()
                .environmentObject(viewModel)
            
        case .GameBoard:
                GameView()
                .environmentObject(viewModel)
            
        case .EndGame:
            ZStack {
                GameView()
                .environmentObject(viewModel)
                EndGameView()
                .environmentObject(viewModel)
            }
            
        case .PauseGame:
            ZStack {
                GameView()
                .environmentObject(viewModel)
                PauseGame()
                .environmentObject(viewModel)
            }
            
        }
    }
}

struct AppMainView_Previews: PreviewProvider {
    static var previews: some View {
        AppMainView()
    }
}
