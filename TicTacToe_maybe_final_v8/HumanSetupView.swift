//
//  HumanSetupView_v2.swift
//  Хрестики-Нолики
//
//  Created by Andrey Starik on 17.01.2023.
//

import SwiftUI



struct HumansSetupView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    
    let maxNameLength = 10
    @State var sign1: Sign = .X
    @State var sign2: Sign = .O
    var signs: [Sign] = [.X, .O]


    var body: some View {
        
        ZStack {
            
            Background()
            
            VStack {
                
                //language button and title
                Group {
                    
                    Button {
                        viewModel.localization.language.ChangeLanguage()
                    } label: {
                        Text(viewModel.localization.language == .ukrainian ? "🇺🇦" : "🇬🇧")
                            .font(.largeTitle)
                    }
                    
                    Divider()
                        .frame(width: viewModel.screenWidth/1000)
                    
                    Text(viewModel.localization.humanSetup().preparationTitle)
                        .font(.custom(viewModel.fontDiya, size: 18))
                        .foregroundColor(.yellow)
                        .padding(.horizontal)
                    
                }
                
                Spacer()
                
                //setup players
                Group {
                    
                    HStack {
                        Text("\(Image(systemName: "person.fill")) \(viewModel.player1.name)")
                            .foregroundColor(viewModel.textColor)
                            .font(.custom(viewModel.fontDiya, size: 18))
                        
                        Button {
                            sign1.toggle()
                            viewModel.player1.sign = sign1
                            
                            viewModel.editingTextField1 = false
                            viewModel.editingTextField2 = false
                            
                            if sign1 == sign2 {
                                sign2.toggle()
                                viewModel.player2.sign = sign2
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(viewModel.textColor)
                                    .frame(width: 25, height: 25)
                                Text(String(describing: sign1))
                                    .font(.system(size: 18))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    
                    MyTextField($viewModel.player1.name,
                                editing: $viewModel.editingTextField1,
                                backgroundColor: .black,
                                textColor: viewModel.textColor,
                                shouldShake: viewModel.shouldShake1)
                    .padding()
                    .onTapGesture { viewModel.editingTextField1 = true }
                    .onChange(of: viewModel.editingTextField1) { newValue in
                        if newValue == false {
                            if viewModel.player1.name.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
                                viewModel.player1.name = "Player1"
                            }
                            //compare names here
                            viewModel.compareNames()
                        }
                    }
                    
                    
                    HStack {
                        Text("\(Image(systemName: "person.fill")) \(viewModel.player2.name)")
                            .foregroundColor(viewModel.textColor)
                            .font(.custom(viewModel.fontDiya, size: 18))
                        
                        Button {
                            sign2.toggle()
                            viewModel.player2.sign = sign2
                            
                            viewModel.editingTextField1 = false
                            viewModel.editingTextField2 = false
                            
                            if sign2 == sign1 {
                                sign1.toggle()
                                viewModel.player1.sign = sign1
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(viewModel.textColor)
                                    .frame(width: 25, height: 25)
                                
                                Text(String(describing: sign2))
                                    .font(.system(size: 18))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    MyTextField($viewModel.player2.name,
                                editing: $viewModel.editingTextField2,
                                backgroundColor: .black,
                                textColor: viewModel.textColor,
                                shouldShake: viewModel.shouldShake2)
                    .padding()
                    .onTapGesture { viewModel.editingTextField2 = true }
                    .onChange(of: viewModel.editingTextField2) { newValue in
                        if newValue == false {
                            if viewModel.player2.name.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
                                viewModel.player2.name = "Player2"
                            }
                            //compare names here
                            viewModel.compareNames()
                        }
                    }
                
                }
                
                Spacer()
                
                //continue button
                Group {
                    Button {
                        viewModel.appState = .GameBoard
                        viewModel.gameMode = .human
                        viewModel.procccessNames()
                    } label: {
                        Text(viewModel.localization.humanSetup().continueButton)
                            .modifier(ButtonStyle(viewModel: _viewModel))
                    }
                }
                
                Divider()
                    .frame(width: viewModel.screenWidth/1000)
                
                
            }
        }
        .onTapGesture {
            viewModel.editingTextField1 = false
            viewModel.editingTextField2 = false
        }
        
    }
}
    
struct HumansSetupView_Previews: PreviewProvider {
    static var previews: some View {
        HumansSetupView()
            .environmentObject(GameViewModel())
    }
}
    
    
    
    

    


    



 
