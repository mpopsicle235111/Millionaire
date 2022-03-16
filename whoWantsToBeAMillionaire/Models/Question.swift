//
//  Question.swift
//  whoWantsToBeAMillionaire
//
//  Created by Anton Lebedev on 10.03.2022.
//

import Foundation

struct Question {
     var answers: [Int: String]
     let validAnswerId: Int
     let questionText: String
     let weight: Int
     

     init(question: String,
          answers: [Int: String],
          validAnswer: Int,
          weight: Int)
     {
         self.validAnswerId = validAnswer
         self.answers = answers
         self.questionText = question
         self.weight = weight
     }
 }
