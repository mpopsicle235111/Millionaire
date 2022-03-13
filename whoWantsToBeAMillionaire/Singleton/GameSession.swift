//
//  GameSession.swift
//  whoWantsToBeAMillionaire
//
//  Created by Anton Lebedev on 10.03.2022.
//

import Foundation

final class GameSession: GameSessionDelegate {
     private var currentSum: Int?
     private var answeredCount: Int?
     private var totalCount: Int?
     private var hints: [HintType: Int] = [
         .callFriend: 1,
         .audienceHelp: 1,
         .hideInvalids: 1
     ]
     func addTotalQuestions(count: Int) {
         totalCount = count
     }

     func getSum() -> Int { currentSum ?? 0 }
     func getAnsweredCount() -> Int { answeredCount ?? 0 }
     func getTotalCount() -> Int { totalCount ?? 0 }

     func addAnsweredQuestion(weight: Int?) {
         if let weight = weight {
             answeredCount = 1 + (answeredCount ?? 0)
             currentSum = weight + (currentSum ?? 0)
         }
     }

     func useHint(hintType: HintType) {
         guard let count = hints[hintType] else { return }
         hints[hintType] = max(count - 1, 0)
     }
 }

 enum HintType {
     case callFriend,
          audienceHelp,
          hideInvalids
 }
