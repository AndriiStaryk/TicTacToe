//
//  MainMenu.swift
//  TicTacToe_v5_refactored
//
//  Created by Andrii Staryk on 22.12.2022.
//

import SwiftUI

struct MainMenu: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    
    var body: some View {
            
        ZStack {
            
            Background()
            
            VStack {
                
                Button {
                    viewModel.localization.language.ChangeLanguage()
                } label: {
                    Text(viewModel.localization.language == .ukrainian ? "🇺🇦" : "🇬🇧")
                        .font(.largeTitle)
                }
                
                Spacer()
                
                //against AI
                
                Button() {
                    viewModel.appState = .AiLevels
                } label: {
                    Text("\(viewModel.localization.mainMenu().againstAI) \(Image(systemName: "pc"))")
                        .modifier(ButtonStyle(viewModel: _viewModel))
                }
                
                Divider()
                    .frame(width: viewModel.screenWidth/1000)
                
                //against Human
                
                Button() {
                    viewModel.appState = .HumansSetup
                    viewModel.player1.name = "Player1"
                    viewModel.player2.name = "Player2"
                } label: {
                    Text("\(viewModel.localization.mainMenu().againstHuman) \(Image(systemName: "person.2.fill"))")
                        .modifier(ButtonStyle(viewModel: _viewModel))
                }
                
                Spacer()
                
                Text(viewModel.localization.language == .ukrainian ? "Цю гру зробив А.Старик ©2022" : "This game developed by A.Staryk ©2022")
                    .font(.custom(viewModel.fontDiya, size: 18))
                    .foregroundColor(viewModel.textColor)
            }.padding()
        }
    }
}



struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
            .environmentObject(GameViewModel())
    }
}


