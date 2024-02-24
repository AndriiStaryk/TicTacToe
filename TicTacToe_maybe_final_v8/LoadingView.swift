//
//  LoadingView.swift
//  TicTacToe_v5_refactored
//
//  Created by Andrii Staryk on 25.12.2022.
//

import SwiftUI

struct LoadingView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    
    
    @State private var size = 0.3
    @State private var opacity = 0.5
    private let loadingTime = 1.5
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Rectangle()
                    .background(.black)
                
                VStack {
                    Spacer()
                    Spacer()
                    
                    Text("Тут могла б бути ваша реклама!")
                        .font(.custom(viewModel.fontDiya, size: 30))
                        .foregroundColor(viewModel.textColor)
                    
                    
                    
               //     HStack(spacing: -5) {
                        
                       
//                        Text("E")
//                            .font(.custom(viewModel.fontEldenRing, size: 60))
//                            .foregroundColor(viewModel.textColor)
//                        Text("LDEN RIN")
//                        //.font(.title)
//                            .font(.custom(viewModel.fontEldenRing, size: 48))
//                            .foregroundColor(viewModel.textColor)
//                        Text("G")
//                            .font(.custom(viewModel.fontEldenRing, size: 60))
//                            .foregroundColor(viewModel.textColor)
                        
              
                    //}
                    Spacer()
//
//                    Text("test")
//                        .font(.custom(viewModel.fontDiya, size: 36))
//                        //.font(.footnote)
//                        .foregroundColor(viewModel.textColor)
                    Spacer()
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: loadingTime)) {
                        self.size = 1
                        self.opacity = 1
                    }
                }
                
            }.ignoresSafeArea()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + loadingTime) {
                        viewModel.appState = .Menu
                        viewModel.screenHeight = geometry.size.height
                        viewModel.screenWidth = geometry.size.width
                    }
                }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
            .environmentObject(GameViewModel())
    }
}
