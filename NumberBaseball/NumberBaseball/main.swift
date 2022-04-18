//
//  NumberBaseball - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
// 

import Foundation

var challenge: Int = 9
var isEnd: Bool = false
var userInput: [Int] = []
var randomNumberAnswer: [Int] = []
let lengthOfGameAnswer: Int = 3

func checkStrikeCount() -> Int {
    var strikeCount = 0
    for index in 0...2 where userInput[index] == randomNumberAnswer[index] {
        strikeCount += 1
        userInput[index] = 0
    }
    return strikeCount
}

func checkBallCount() -> Int {
    var ballCount = 0
    for index in 0...2 where randomNumberAnswer.contains(userInput[index]) {
        ballCount += 1
    }
    return ballCount
}

func createRandomNumbers() -> [Int] {
    var result = Set<Int>()
    while result.count < 3 {
        result.insert(Int.random(in: 1...9))
    }
    return Array(result)
}

func checkUserInput() -> Bool {
    guard let userNumber = readLine()?.components(separatedBy: " ") else {
        print("입력이 잘못되었습니다\n숫자 3개를 띄어쓰기로 구분하여 입력해주세요.\n중복 숫자는 허용하지 않습니다.")
        return true
    }
    if validate(of: userNumber).isEmpty == false {
        userInput = validate(of: userNumber)
        return false
    } else {
        return true
    }
}

func getUserInput() {
    var isValid = true
    while isValid {
        print("입력 :", terminator: " ")
        isValid = checkUserInput()
    }
}

func validate(of input: [String]) -> [Int] {
    var checkedDuplicatedNumbers = Set<String>()
    var correctInputCount: Int = 0
    for input in input {
        checkedDuplicatedNumbers.insert(input)
    }
    let checkedInput: [Int] = input.map({ (number: String) -> Int in
        return Int(number) ?? -1
    })
    for checkedNumber in checkedInput where (1...9).contains(checkedNumber) {
        correctInputCount += 1
    }
    guard checkedDuplicatedNumbers.count == lengthOfGameAnswer,
            input.count == lengthOfGameAnswer,
            correctInputCount == lengthOfGameAnswer
    else {
        print("입력이 잘못되었습니다\n숫자 3개를 띄어쓰기로 구분하여 입력해주세요.\n중복 숫자는 허용하지 않습니다.")
        return []
    }
    return checkedInput
}

func printWinner(_ winner: String) {
    isEnd = true
    print("\(winner) 승리...!")
}

func checkWinner(strikeCount: Int) {
    if strikeCount == 3 {
        printWinner("유저")
        return
    }
    if challenge == 0 {
        printWinner("컴퓨터")
    }
}

func playGame() {
    randomNumberAnswer = createRandomNumbers()
    isEnd = false
    challenge = 9
    while !isEnd {
        getUserInput()
        let strikeCount: Int = checkStrikeCount()
        let ballCount: Int = checkBallCount()
        challenge -= 1
        print("\(strikeCount) 스트라이크, \(ballCount) 볼 \n남은 기회 : \(challenge)")
        checkWinner(strikeCount: strikeCount)
    }
}

func getMenuInput() -> Bool {
    let menuInput = readLine()
    if menuInput == "1" {
        playGame()
        return true
    } else if menuInput == "2" {
        return false
    } else {
        print("입력이 잘못되었습니다.")
        return true
    }
}

func startGame() {
    var canPlay = true
    while canPlay {
        print("1. 게임시작 \n2. 게임 종료 \n원하는 기능을 선택해주세요 : ", terminator: "")
        canPlay = getMenuInput()
    }
}

startGame()
