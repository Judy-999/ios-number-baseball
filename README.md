# 숫자게임

---

## ⚾️ 게임 설명 

### [ 숫자게임 ]
야구의 스트라이크, 볼에서 따온 숫자 맞추기 게임.
컴퓨터가 임의로 생성한 숫자를 맞춰보세요.
스트라이크와 볼로 힌트를 줍니다! 😁

### [ 게임 조건 ]

- `스트라이크` - 맞는 숫자가 정확한 자리에 있습니다.
- `볼` - 같은 숫자가 존재하지만 자리가 맞지 않습니다.
- 숫자를 맞추는 도전 기회는 총 `9번`입니다.

### [ 게임 방법 ]
1. 게임 메뉴를 선택합니다.  -  `1) 게임시작 2) 게임 종료`
2. 3가지 숫자를 입력합니다.
3. 컴퓨터가 알려준 스트라이크와 볼의 개수로  숫자를 예상해서 입력합니다.
4. 만약 숫자를 모두 맞혔다면 사용자의 승리로 종료됩니다.
5. 만약 9번의 기회를 모두 소모했다면 컴퓨터의 승리로 종료됩니다.
6. 게임이 종료되면 다시 게임 메뉴를 선택할 수 있습니다.

<br/>

---

<br/>

## 📃 순서도 

<br/>

![](https://i.imgur.com/8Cq59Bg.png)

<br/>

---

<br/>

## 🔍 코드 설명

### 게임 진행
`playGame()` - 게임을 진행하는 메인이 되는 함수

```swift
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
```

<br/>

> 1. 메뉴에서 게임 시작을 선택하면 `playGame()` 동작
> 2. 컴퓨터의 랜덤 숫자(`randomNumberAnswer`) 생성
> 3. `getUserInput()` - 사용자에게 숫자를 입력받음
> 4. `checkStrikeCount()`, `checkBallCount()` - 스트라이크와 볼 개수 확인
> 5. `challenge -= 1` - 기회 1 소모
> 6. 스트라이크 개수, 볼 개수, 남은 기회 출력
> 7. `checkWinner` - 승자가 있는지 확인 후 있으면 출력 후 종료
> 8. 다시 메뉴 선택으로 돌아감

<br/>

### 사용자 입력 오류처리
```swift
func validate(of input: [String]) -> [Int] {
    var checkOverlapSet = Set<String>()
    var correctInputCount: Int = 0
    for input in input {
        checkOverlapSet.insert(input)
    }
    let checkedInput: [Int] = input.map({ (number: String) -> Int in
        return Int(number) ?? -1
    })
    for checkedNumber in checkedInput where (1...9).contains(checkedNumber) {
        correctInputCount += 1
    }
    guard checkOverlapSet.count == lengthOfGameAnswer,
            input.count == lengthOfGameAnswer,
            correctInputCount == lengthOfGameAnswer
    else {
        print("입력이 잘못되었습니다\n숫자 3개를 띄어쓰기로 구분하여 입력해주세요.\n중복 숫자는 허용하지 않습니다.")
        return []
    }
    return checkedInput
}
```
<br/>

 
> #### 1. 중복된 숫자가 입력된 경우
> 입력 받은 숫자를 Set에 넣어보고 count를 확인한다.
> #### 2. 숫자가 아닌 문자가 입력된 경우
> `map`을 통해 `Int`로 변환해보고 변환되지 않는 문자는 `-1`로 구분한다.
> #### 3. 숫자의 범위를 벗어났을 경우
> Int로 변환된 숫자가 (1...9) 이내인지 확인한다.
> #### 4. 띄어쓰기로 구분이 되어있지 않을 경우
> 입력 받은 숫자의 count를 확인한다.

<br/>

### 스트라이크 개수 확인
```swift
func checkStrikeCount() -> Int {
    var strikeCount = 0
    for index in 0...2 where userInput[index] == randomNumberAnswer[index] {
        strikeCount += 1
        userInput[index] = 0
    }
    return strikeCount
}
```
사용자 입력(`userInput`)과 정답(`randomNumberAnswer`)이 같은 인덱스에서 같은 숫자를 받는지 확인

‼️ 만약 숫자가 같다면 스트라이크이므로 볼을 판단할 필요가 없어 해당 자리를 `0`으로 변경한다. 

<br/>

### 볼 개수 확인
```swift
func checkBallCount() -> Int {
    var ballCount = 0
    for index in 0...2 where randomNumberAnswer.contains(userInput[index]) {
        ballCount += 1
    }
    return ballCount
}
```

스트라이크인 경우는 이미 `0`이므로 정답의 숫자 중에 사용자가 입력한 숫자가 있는지 확인한다.
<br/>

---

## 🤔 고민과 해결

### [ 이중들여쓰기 ]

1. 함수로 분리 
```swift
while !isEnd {
    ~
    for randomNumber in randomNumbers{
        print(randomNumber, terminator: " ")
    }
    ~
}
```

랜덤 숫자들을 출력하는 단순한 부분이지만 반복문 속에 들어가 이중들여쓰기가 된 부분이다.

```swift
func printRandomNumber(_ numbers: [Int]){
    for number in numbers{
        print(number, terminator: " ")
    }
}

while !isEnd {
    ~
      printRandomNumber(randomComputerInput)
    ~
}
```
출력하는 함수로 분리해서 재사용성과 가독성도 높이며 해결했다.

2. 반목분과 조건문 결합
```swift
for index in 0...2 {
    if randomNumberAnswer.contains(randomInput[index]) {
        countList[1] += 1
    }
}
```

반복문을 돌며 특정 조건일 때 수행하고 싶은 코드가 있을 때 반복문 속 조건문이 되어 이중들여쓰기가 된 부분이다.

```swift
for index in 0...2 where randomNumberAnswer.contains(randomComputerInput[index]) {
    ballCount += 1
}
```

for문 뒤에 where을 붙여주면 where 절에 해당하는 요소만 반복하므로 들여쓰기 없이 한 줄로 쓸 수 있었다.
<br/>

### [ 네이밍과 코드 컨벤션 ]

함수와 변수의 이름을 짓고, 코드의 컨벤션을 맞추고 통일하는 것에 많은 시간을 할애했다.
쉬워보이면서도 리뷰에서 반복적으로 코멘트된 사항이다 🥲

- 변수나 함수명에 타입이름이 들어가는 건 지양하기
- 줄바꿈은 통일성 있게 하기
- 비슷한 의미의 이름을 반복하지 않기
- 타입 선언식도 가능한 통일하기
- 출력문은 한 줄로 갈끔하게 하기

등등 여러 조언을 받아 네이밍과 코드 컨벤션을 수정하였다.

<br/><br/>
