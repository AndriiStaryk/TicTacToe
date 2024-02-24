//
//  Enums.swift
//  TicTacToe_v5_refactored
//
//  Created by Andrii Staryk on 27.12.2022.
//

import Foundation
import SwiftUI

enum Player {
    case human,computer,human2
}

enum Mode {
    case human, easyAI, hardAI
}

enum AppState {
    case Menu, AiLevels, GameBoard, Loading, EndGame, PauseGame, HumansSetup
}

enum Language {
    case ukrainian, english
}

extension Language {
    mutating func ChangeLanguage() {
        if self == .ukrainian {
            self = .english
        } else {
            self = .ukrainian
        }
    }
}



enum GameEndings {
    case humanWinAI, computerWin, draw, human2Win, humanWinHuman
}

enum Sign: CustomStringConvertible {
    case X, O
    
    var description: String {
        switch self {
        case .X: return "X"
        case .O: return "O"
        }
    }
}

extension Sign {
    mutating func toggle() {
        if self == .X {
            self  = .O
        } else {
            self = .X
        }
    }
}


class PlayerInfo {
    
    var name: String
    var sign: Sign
    
    public init(name: String, sign: Sign) {
        self.name = name
        self.sign = sign
    }
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
    
    var squareColor: Color {
        //return player == .human ? .green : .red
        return player == .human ? Color(red: 15/256, green: 50/256, blue: 51/256) : Color(red: 134/256, green: 0, blue: 6/256)
    }
}

