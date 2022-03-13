//
//  GameSessionResult.swift
//  whoWantsToBeAMillionaire
//
//  Created by Anton Lebedev on 10.03.2022.
//

import Foundation

struct GameSessionResult: Codable {
     var money = 0
     var answered = 0
     var percent = 0

     init(money: Int, answeredCount: Int, answeredPercent: Int) {
         self.money = money
         self.answered = answeredCount
         self.percent = answeredPercent
     }

     func description() -> String {
         "Cash: " + String(money) + 
             "  Answers: " + String(answered) +
             " Success: " + String(percent) + "%" + " ================="
     }

     enum CodingKeys: String, CodingKey {
         case money
         case answered
         case percent
     }
 }
