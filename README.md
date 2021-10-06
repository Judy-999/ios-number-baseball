# 숫자야구 프로젝트

## 프로젝트 소개
* 플레이어 1명이 참여하여 컴퓨터와 숫자야구 게임을 진행합니다.
* 숫자야구 게임 규칙  
  1. 컴퓨터는 중복되지 않은 임의의 숫자 3개를 생성합니다.
  1. 게임이 끝날 때까지 사용자는 숫자 1~9 사이에서 중복되지 않은 3개의 숫자를 입력합니다.
  1. 컴퓨터가 만든 3개 숫자와 사용자가 입력한 3개 숫자를 비교하여 스트라이크와 볼을 판정합니다.  
(숫자와 숫자 위치가 동일하면 스트라이크, 숫자는 동일하지만 숫자 위치가 다르면 볼로 판정합니다.)
  1. 사용자가 9번의 기회 안에 3 스트라이크를 얻으면 승리합니다. 기회를 소진하면 컴퓨터가 승리합니다.  

## STEP 0
---
STEP 1 및 STEP 2의 순서도 (순서도 이미지 추가)

## STEP 1
---
### 구현 내용
1. 다음 변수를 생성합니다  
i. 컴퓨터가 제시할 임의의 정수 3개를 담아둘 변수  
ii. 남은 시도횟수를 담아둘 변수(초기값은 9입니다)
1. 다음 함수를 구현합니다  
i. 1~9 사이의 3개의 임의의 정수를 생성하여 반환하는 함수(생성한 3개의 정수는 중복된 수가 없어야 합니다)
1. 3개의 정수를 전달받아 [1-1]의 수와 비교하여 볼과 스트라이크 결과를 반환하는 함수
1. 게임시작 함수  
이번 스텝에서는 사용자 입력없이 임의의 수를 생성하여 게임을 진행하도록 구현합니다

### 고려사항
1. 주요 변수
    - computerRandomNumbers/playerRandomNumbers : 순서가 있는 3개의 값을 저장하므로 배열을 사용함
    - trialCount/strike/ball : 시도횟수, 스트라이크, 볼의 값을 나타낼 변수는 여러 함수에서 접근해야 하므로 전역변수로 선언함
    - isGameOver : 게임이 종료될 때까지 계속해서 사용자 입력을 받아야 하므로 Bool 타입 변수를 선언했고, reset 함수에서 while 문의 조건으로 사용함
1. 주요 함수
    - makeDeduplicatedRandomNumbers : 중복되지 않는 숫자를 생성하기 위해 Set 타입을 활용함
    - checkSameNumbers : 컴퓨터/사용자의 숫자 중에서 동일한 숫자가 존재하는지 확인하고, 동일한 숫자를 배열로 반환함. Set 타입의 intersection 메서드를 사용함
    - checkSameOrder : for-in문을 통해 컴퓨터/사용자의 동일한 숫자가 저장된 배열의 요소에 하나씩 접근함. 그리고 해당 숫자가 각 컴퓨터/사용자 숫자의 몇 번 index에 위치하는지 확인함. 같은 index라면 스트라이크, 같은 index가 아니면 볼의 값을 1씩 더하여 할당함
    - compareNumbers : 컴퓨터/사용자의 숫자 중에서 동일한 숫자가 존재하지 않으면, 함수를 종료함. 동일한 숫자가 존재하면, checkSameOrder를 호출함
  
### 출력 결과  
(출력 결과 이미지 추가)

## STEP 2
---
(추가 예정)
