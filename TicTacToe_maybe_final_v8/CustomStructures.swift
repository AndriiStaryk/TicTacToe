//
//  CustomStructures.swift
//  Хрестики-Нолики
//
//  Created by Andrey Starik on 19.01.2023.
//

import Foundation
import SwiftUI


struct GameSquareView: View {
    
    var width: Double
    var buttonColor: Color
    var strokeColor: Color

    var body: some View {
        ZStack{
            Circle()
                .foregroundColor(strokeColor)
                .frame(width: width/3 - 15,
                       height: width/3 - 15)
            Circle()
                .frame(width: width/3-24,
                       height: width/3-24)
                .foregroundColor(buttonColor)
            
        }
    }
}

struct PlayerIndicator: View {
    
    var systemImageName: String
    var width: Double
    var color: Color
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: systemImageName == "circle" ? width/8 : width/9, height: systemImageName == "circle" ? width/8 : width/9)
            .foregroundColor(color)
    }
    
}

struct Background: View {
    
    var body: some View {
        //darkBiruzovuy = Color(red: 15/256, green: 50/256, blue: 51/256)
        //middle rgb(8,25,26)
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.black, Color(red: 15/256, green: 50/256, blue: 51/256)]),
                        startPoint: .top,
                        endPoint: .bottom)
                    )
                .ignoresSafeArea()
    }
}


struct MyTextField: View {
    
    
    let maxNameLength = 10
    let fieldErrorColor: Color = .red
    let darkGreen: Color = Color(red: 4/256, green: 48/256, blue: 33/256)
    let fieldNotActiveColor: Color = .gray
    @State var fieldBackgroundColor: Color
    @State var textColor: Color
    
    @State private var borderColor = Color(red: 4/256, green: 48/256, blue: 33/256)
    @State private var borderWidth = 1.0
    @Binding private var editing: Bool
    @FocusState private var focusField: Field?
    @Binding private var text: String
    @State var shouldShake: Bool
    
    init(_ text: Binding<String>, editing: Binding<Bool>, backgroundColor: Color, textColor: Color, shouldShake: Bool) {
        self._text = text
        self._editing = editing
        self.fieldBackgroundColor = backgroundColor
        self.textColor = textColor
        self.shouldShake = shouldShake
    }
    
    private enum Field {
        case textField
    }
    
    var body: some View {
        
        TextField("", text: $text)
            .padding(6.0)
            .font(.custom("e-Ukraine-Regular", size: 18))
            .background(RoundedRectangle(cornerRadius: 4.0, style: .continuous)
                .stroke(borderColor, lineWidth: borderWidth)
                .background(fieldBackgroundColor))
            .foregroundColor(textColor)
            .focused($focusField, equals: .textField)
            .onChange(of: text, perform: { newValue in
                if editing {
                    
                    if newValue.count == maxNameLength + 1 {
                        text = String(newValue.prefix(maxNameLength))
                        borderColor = fieldErrorColor
                        shouldShake = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        shouldShake = false
                        borderColor = textColor
                    }
                    
                } else {
                    if text.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
                        text = "Player"
                    }
                }
                
            })
            .onChange(of: editing) {
                focusField = $0 ? .textField : nil
                withAnimation(.easeOut(duration: 0.1)) {
                    borderColor = editing ? textColor : darkGreen
                    borderWidth = editing ? 4.0 : 3.0
                }
            }
            .modifier(ShakeEffect(shakes: shouldShake ? 2 : 0))
            .animation(Animation.default.repeatCount(4).speed(3), value: shouldShake)
    }
    
}


struct ShakeEffect: GeometryEffect {
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX: -30 * sin(position * 2 * .pi), y: 0))
    }
    
    init(shakes: Int) {
        position = CGFloat(shakes)
    }
    
    var position: CGFloat
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
}



struct ButtonStyle: ViewModifier {
   
    @EnvironmentObject var viewModel: GameViewModel
    
    func body(content: Content) -> some View {
        
        content
            .font(.custom(viewModel.fontDiya, size: viewModel.fontSize))
            .frame(width: viewModel.screenWidth/1.2, height: viewModel.screenWidth/4)
            .background(viewModel.buttonBackgroundColor)
            .foregroundColor(viewModel.textColor)
            .cornerRadius(15)
            .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(viewModel.textColor, lineWidth: 3)
            )
    }
}
