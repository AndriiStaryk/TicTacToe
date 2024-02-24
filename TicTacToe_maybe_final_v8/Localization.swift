//
//  Localizations.swift
//  TicTacToe_v5_refactored
//
//  Created by Andrii Staryk on 20.12.2022.
//

import Foundation


struct Localization {
    
    var language: Language
    
    var title: String = ""
    var message: String = ""

    mutating func endGameMessage(gameEndings: GameEndings,  playerCross: String, playerNaught: String) {
        switch gameEndings {
        case .humanWinAI:
            title = language == .ukrainian ? "Ви перемогли!" : "You won!"
            message = language == .ukrainian ? "А ви в біса – розумні. Ви не дали цій бляшанці жодного шансу" : "You are so smart. You beat AI"
        case .computerWin:
            title = language == .ukrainian ? "Ви програли(" : "You lost..."
            message = language == .ukrainian ? "Це була надзвичайно запекла боротьба. Ви грали неймовірно, але... Результат на табло" : "It was such a decent battle, but this time AI was better"
        case .draw:
            title = language == .ukrainian ? "Нічия" : "Draw"
            message = language == .ukrainian ? "В цьому поєдинку розумів немає переможця..." : "There is no winner in such a decent battle..."
        case .human2Win:
            title = language == .ukrainian ? "\(playerNaught) переміг!" : "\(playerNaught) won!"
            message = language == .ukrainian ? "\(playerCross) грав добре, але \(playerNaught) був трохи краще" : "\(playerCross) was playing good, but \(playerNaught) were a little bit better"
//            title = language == .ukrainian ? "Ваш друг переміг!" : "Your friend won!"
//            message = language == .ukrainian ? "А ваш суперник не дурний:) Реванш?" : "Your friend not a dull one:) One more?"
        case .humanWinHuman:
            title = language == .ukrainian ? "\(playerCross) переміг!" : "\(playerCross) won!"
            message = language == .ukrainian ? "\(playerNaught) грав добре, але \(playerCross) був трохи краще" : "\(playerNaught) was playing good, but \(playerCross) were a little bit better"
//            title = language == .ukrainian ? "Ви перемогли!" : "You won!"
//            message = language == .ukrainian ? "Ваш друг грав добре, але ви були трохи краще" : "Your friend was playing good, but you were a little bit better"
        }
    }
    
    func mainMenu() -> (againstAI: String, againstHuman: String) {
        let againstAI = language == .ukrainian ? "Грати з AI" : "Play with AI"
        let againstHuman = language == .ukrainian ? "Грати з людиною" : "Play with human"
        return (againstAI,againstHuman)
    }
    
    func endGameButtons() -> (playAgainButton: String, mainMenuButton: String) {
        let playAgainButton = language == .ukrainian ? "Грати знову" : "Play again"
        let mainMenuButton = language == .ukrainian ? "Головне меню" : "Main Menu"
        return (playAgainButton, mainMenuButton)
    }
    
    func ailevels() -> (aiLevel: String,easy: String, hard: String) {
        let aiLevel = language == .ukrainian ? "Рівень штучного інтелекту:" : "AI's difficulty:"
        let easy = language == .ukrainian ? "Легкий" : "Easy"
        let hard = language == .ukrainian ? "Складний" : "Hard"
        return (aiLevel,easy,hard)
    }
    
    func humanSetup() -> (preparationTitle: String,continueButton: String) {
        let preparationTitle = language == .ukrainian ? "Підготовка перед грою" : "Preparation before the game"
        let continueButton = language == .ukrainian ? "Продовжити" : "Сontinue"
        return (preparationTitle, continueButton)
    }
    
    func pauseGameButtons() -> (resumeGame: String , restartGame: String , toMainMenu: String) {
        let resumeGame = language == .ukrainian ? "Продовжити" : "Continue"
        let restartGame = language == .ukrainian ? "Грати заново" : "Restart Game"
        let toMainMenu = language == .ukrainian ? "Головне меню" : "Main Menu"
        return (resumeGame, restartGame, toMainMenu)
    }
}
