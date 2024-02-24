//
//  GameViewModel.swift
//  Tic-Tac-ToeV4_Refactored
//
//  Created by Andrii Staryk on 19.12.2022.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()) ]
    
    
    @Published var screenHeight = 0.0
    @Published var screenWidth = 0.0
    
    //Colors
    let textColor: Color = Color(red: 1, green: 0.839, blue: 0)
    let buttonBackgroundColor: Color = Color(red: 15/256, green: 50/256, blue: 51/256)
    let fieldErrorColor: Color = .red
    let darkGreen: Color = Color(red: 4/256, green: 48/256, blue: 33/256)
    let darkCyan = Color(red: 19/256, green: 140/256, blue: 137/256)
    //
    
    let fontDiya: String = "e-Ukraine-Regular"
    let fontSize = 30.0
    let fontEldenRing: String = "Mantinia"
    
    let maxNameLength = 10
    //Diya Setup
    
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameBoardDisabled = false
    @Published var appState: AppState = .Loading
    @Published var currentPlayer = Player.human
    @Published var gameEnding: GameEndings? //maybe add unexpected game ending
    
    @Published var localization: Localization = Localization(language: .ukrainian)
    @Published var gameMode: Mode = .human
    @Published var isGameEnded = false
    
    @Published var player1: PlayerInfo = PlayerInfo(name: "player1", sign: .X)
    @Published var player2: PlayerInfo = PlayerInfo(name: "player2", sign: .O)
    
    @Published var shouldShake1 = false
    @Published var shouldShake2 = false
    
    
    @Published var editingTextField1 = false {
        didSet {
            guard editingTextField1 != oldValue else { return }
            if editingTextField1 {
                editingTextField2 = false
            }
        }
    }
    
    @Published var editingTextField2 = false {
        didSet {
            guard editingTextField2 != oldValue else { return }
            if editingTextField2 {
                editingTextField1 = false
            }
        }
    }
    
    
    func processPlayerMove(for position: Int, mode: Mode, player: Player) {
        
        //human's move processing  (human and human2)
        if isSquareOccupied(in: moves, forIndex: position) { return }
        moves[position] = Move(player: player, boardIndex: position)
        
        //check for win or draw
        if checkWinCondition(for: player, in: moves) {
            if gameMode == .human {
                endGame(player == .human ? .humanWinHuman : .human2Win,
                        playerCross: playerCrossAndNaughtsFinder(playerr1: player1, playerr2: player2).playerCross,
                        playerNaught: playerCrossAndNaughtsFinder(playerr1: player1, playerr2: player2).playerNaught)
            } else {
                endGame(player == .human ? .humanWinAI : .human2Win, playerCross: "You", playerNaught: "AI")
            }
            return
        }
        if checkForDraw(in: moves) {
            endGame(.draw, playerCross: "human1", playerNaught: "human2")
            return
        }
        
        if mode == .human {
            currentPlayer = currentPlayer == .human ? .human2 : .human
            return
        }
        else {
            isGameBoardDisabled = true
            
            //computer move processing
            //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                let computerPosition = determineComputerMovePosition(in: moves, difficulty: gameMode)
                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                isGameBoardDisabled = false
                
                if checkWinCondition(for: .computer, in: moves) {
                    endGame(.computerWin, playerCross: "You", playerNaught: "AI")
                    return
                }
                if checkForDraw(in: moves) {
                    endGame(.draw, playerCross: "You", playerNaught: "AI")
                    return
                }
            }
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index})
    }
    
    func determineComputerMovePosition(in moves: [Move?], difficulty gameMode: Mode) -> Int {
        
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8],[0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        if gameMode == .hardAI || gameMode == .easyAI {
            
            //If AI can win, then win
            //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
            let computerMoves = moves.compactMap { $0 }.filter{ $0.player == .computer}
            let computerPositions = Set(computerMoves.map { $0.boardIndex })
            
            for pattern in winPatterns {
                let winPositions = pattern.subtracting(computerPositions)
                
                if winPositions.count == 1 {
                    let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                    if isAvailable { return winPositions.first!}
                }
            }
            
        }
        
        //If AI can't win, then block
        //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
        if gameMode == .hardAI  {
            let humanMoves = moves.compactMap { $0 }.filter{ $0.player == .human}
            let humanPositions = Set(humanMoves.map { $0.boardIndex })
            
            for pattern in winPatterns {
                let winPositions = pattern.subtracting(humanPositions)
                
                if winPositions.count == 1 {
                    let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                    if isAvailable { return winPositions.first!}
                }
            }
        }
        
        //If AI can't block? then take middle square
        //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
        if gameMode == .hardAI || gameMode == .easyAI {
            let centerSquare = 4
            if !isSquareOccupied(in: moves, forIndex: centerSquare) {
                return centerSquare
            }
        }
        
        
        //If AI can't take middle square, take random available square
        //-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
        var movePosition = Int.random(in: 0..<9)
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        return movePosition
        
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8],[0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let playerMoves = moves.compactMap { $0 }.filter{ $0.player == player}
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
        isGameBoardDisabled = false
        currentPlayer = .human
        isGameEnded = false 
    }
    
    func endGame(_ gameEnd: GameEndings, playerCross: String, playerNaught: String)  {
        appState = .EndGame
        gameEnding = gameEnd
        isGameBoardDisabled = true
        localization.endGameMessage(gameEndings: gameEnd, playerCross: playerCross, playerNaught: playerNaught)
        isGameEnded = true
    }
    
    func pauseGame() {
        appState = .PauseGame
        isGameBoardDisabled = true
    }
    
    func continueGame() {
        if isGameEnded {
            isGameBoardDisabled = true
        } else {
            isGameBoardDisabled = false
        }
        
        appState = .GameBoard
    }
    
    func playerCrossAndNaughtsFinder(playerr1: PlayerInfo, playerr2: PlayerInfo) -> (playerCross: String ,playerNaught: String) {
        if playerr1.sign == .X {
            return (playerr1.name, playerr2.name)
        } else {
            return (playerr2.name,playerr1.name)
        }
    }
    
    func procccessNames()  {
        
        if player1.name.trimmingCharacters(in: .whitespacesAndNewlines).count == 0  {
            player1.name = "Player1"
        }
        
        if player2.name.trimmingCharacters(in: .whitespacesAndNewlines).count == 0  {
            player2.name = "Player2"
        }
    }
    
    func compareNames() {
        var trimmedName1 = Array(player1.name.trimmingCharacters(in: .whitespacesAndNewlines))
        var trimmedName2 = Array(player2.name.trimmingCharacters(in: .whitespacesAndNewlines))
        
        if trimmedName1 == trimmedName2 {
            trimmedName1[trimmedName1.endIndex-1] = "1"
            trimmedName2[trimmedName1.endIndex-1] = "2"
        }
        
        player1.name = String(trimmedName1)
        player2.name = String(trimmedName2)
    }
       
}








