//
//  GameView.swift
//  TicTacToe_V4
//
//  Created by Andrii Staryk on 19.12.2022.
//

import SwiftUI



struct GameView: View {
    @EnvironmentObject var viewModel: GameViewModel
    
    var body: some View {
        
        ZStack {
            
            Background()
            
            VStack() {
                HStack {
                    Spacer()
                    
                    Button {
                        viewModel.pauseGame()
                    } label: {
                        
                        Image(systemName: viewModel.appState == .PauseGame ? "play.fill" : "pause.fill")
                            .font(.largeTitle)
                            .foregroundColor(.yellow)
                    }
                    
                    Button {
                        viewModel.localization.language.ChangeLanguage()
                    } label: {
                        Text(viewModel.localization.language == .ukrainian ? "🇺🇦" : "🇬🇧")
                            .font(.largeTitle)
                    }
                    
                    Spacer()
                }
                
                //players Info
                
                Text("\(viewModel.player1.name) - \(String(describing: viewModel.player1.sign))")
                    .font(.custom(viewModel.fontDiya, size: 24))
                    .foregroundColor(viewModel.textColor)
                    .padding(.horizontal)
                
                Spacer()
                
                LazyVGrid(columns: viewModel.columns, spacing: 5) {
                    ForEach(0..<9) { i in
                        ZStack {
                            
                            GameSquareView(width: viewModel.screenWidth,
                                           buttonColor: viewModel.moves[i]?.squareColor ?? viewModel.textColor,
                                           strokeColor: viewModel.textColor)
                            
                            PlayerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "",
                                            width: viewModel.screenWidth,
                                            color: viewModel.textColor)
                            
                        }
                        .onTapGesture {
                            viewModel.processPlayerMove(for: i, mode: viewModel.gameMode, player: viewModel.currentPlayer)
                        }
                    }
                }.disabled(viewModel.isGameBoardDisabled)
                
                Spacer()
                
                Text("\(viewModel.player2.name) - \(String(describing: viewModel.player2.sign))")
                    .font(.custom(viewModel.fontDiya, size: 24))
                    .foregroundColor(viewModel.textColor)
                    .padding(.horizontal)
                
            }
            .padding()
            .blur(radius: viewModel.appState == .EndGame ? 40 : 0)
            .blur(radius: viewModel.appState == .PauseGame ? 40 : 0)
            
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameViewModel())
    }
}




