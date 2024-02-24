//
//  EndGameView.swift
//  TicTacToe_v5_refactored
//
//  Created by Andrii Staryk on 28.12.2022.
//

import SwiftUI

struct EndGameView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    
    @State private var offsetY = -500.0
    // let width = 350.0
    //  let height = 200.0
    
    var body: some View {
        
            VStack {
                
                HStack {
                    Spacer()
                    Button {
                        viewModel.appState = .GameBoard
                    } label: {
                        Image(systemName: "xmark")
                    }.frame(alignment: .topTrailing)
                        .padding(.top)
                        .foregroundColor(viewModel.textColor)
                    
                }
                
                
                //title
                Text("\(viewModel.localization.title)")
                    .font(.custom(viewModel.fontDiya, size: 24))
                    .bold()
                    .foregroundColor(viewModel.textColor)
                Spacer()
                //message
                Text("\(viewModel.localization.message)")
                    .font(.custom(viewModel.fontDiya, size: 18))
                    .foregroundColor(viewModel.textColor)
                
                Spacer()
                
                
                //buttons
                HStack {
                    
                    Divider()
                        .frame(height: viewModel.screenWidth/1000)
                    
                    Button() {
                        viewModel.appState = .GameBoard
                        viewModel.resetGame()
                    } label: {
                        
                        Text("\(viewModel.localization.endGameButtons().playAgainButton)")
                            .frame(width: viewModel.screenWidth/2.4, height: viewModel.screenWidth/7)
                            .font(.custom(viewModel.fontDiya, size: 18))
                            .foregroundColor(viewModel.textColor)
                            .background(viewModel.buttonBackgroundColor)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(viewModel.textColor, lineWidth: 3)
                            )
                    }
                    
                    Divider()
                        .frame(height: viewModel.screenWidth/1000)
                    
                    Button() {
                        viewModel.appState = .Menu
                        viewModel.resetGame()
                    } label: {
                        Text("\(viewModel.localization.endGameButtons().mainMenuButton)")
                            .frame(width: viewModel.screenWidth/2.4, height: viewModel.screenWidth/7)
                            .font(.custom(viewModel.fontDiya, size: 18))
                            .foregroundColor(viewModel.textColor)
                            .background(viewModel.buttonBackgroundColor)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(viewModel.textColor, lineWidth: 3)
                            )
                    }
                    
                    Divider()
                        .frame(height: viewModel.screenWidth/1000)
                    
                }.padding(.horizontal)
                
                Divider()
                    .frame(width: viewModel.screenWidth/1000)
                //Spacer()
            }
        .padding(.horizontal)
        .frame(width: viewModel.screenWidth/1.1,  //1.5
               height: viewModel.screenWidth/1.75) //1.5
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 15/256, green: 50/256, blue: 51/256), .black]),
                startPoint: .top,
                endPoint: .bottom)
        )
        .cornerRadius(20)
        .offset(y: offsetY)
        .onAppear {
            withAnimation(.easeIn(duration: 0.25)) {
                self.offsetY = 0
            }
        }
    }
}

struct EndGameView_Previews: PreviewProvider {
    static var previews: some View {
        EndGameView()
            .environmentObject(GameViewModel())
    }
}
