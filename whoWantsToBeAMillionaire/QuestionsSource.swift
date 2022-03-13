//
//  QuestionsSource.swift
//  whoWantsToBeAMillionaire
//
//  Created by Anton Lebedev on 09.03.2022.
//

import Foundation

final class QuestionsSource {
     private var questions = [
         Question(question: "The Sherlock Holmes' way of thinking, where the conclusions were derived from common to private, is called...",
                  answers: [1: "Deduction",
                            2: "Reduction",
                            3: "Induction",
                            4: "Reproduction"],
                  validAnswer: 1,
                  weight: 100),
         Question(question: "The ecomonic good is characterized by the fact, that it is...",
                  answers: [1: "virtually unlimited",
                            2: "limited",
                            3: "sold in every store",
                            4: "domestcally produced"],
                  validAnswer: 2,
                  weight: 200),

         Question(question: "The Greek philosopher Xenophon's work about the housekeeping was called...",
                  answers: [1: "Chrematistics",
                            2: "Fake Chrematistics",
                            3: "Xenophonicus",
                            4: "Oeconomicus"],
                  validAnswer: 4,
                  weight: 400),
         Question(question: "Mercantilism states, that the wealth of the country should best be measured in...",
                  answers: [1: "wheat bushels",
                            2: "manufactured goods",
                            3: "golden coins",
                            4: "educated people"],
                  validAnswer: 3,
                  weight: 200),
         Question(question: "In François Quesnay's Tableau Economique, who holds the money at the beginnig of the year?",
                  answers: [1: "productive class",
                            2: "sterile class",
                            3: "property owners",
                            4: "clergy"],
                  validAnswer: 2,
                  weight: 400),
         Question(question: "Two Latin letters, that traditionally describe marginal costs, are...",
                  answers: [1: "MC",
                            2: "WC",
                            3: "FC",
                            4: "AC"],
                  validAnswer: 1,
                  weight: 100),
         Question(question: "In the process good's consumption, the marginal utility tends to be...",
                  answers: [1: "increasing",
                            2: "decreasing",
                            3: "constant",
                            4: "nil"],
                  validAnswer: 2,
                  weight: 100),
         Question(question: "A student has bought a bottle of cold tea for 50 cents and drank it dry. The bottle utility is 50 utils. What are the average costs per utility unit?",
                  answers: [1: "2 cents",
                            2: "1 cent",
                            3: "0.5 cents",
                            4: "50 cents"],
                  validAnswer: 1,
                  weight: 200),
         Question(question: "How much paper volumes does Das Kapital have?",
                  answers: [1: "3",
                            2: "4",
                            3: "5",
                            4: "6"],
                  validAnswer: 2,
                  weight: 400),
         Question(question: "The pensioner's marginal propensity to save is 0.9. What is the same pensioner's marginal propensity to consume?",
                  answers: [1: "0.1",
                            2: "1.0",
                            3: "0.9",
                            4: "9.0"],
                  validAnswer: 1,
                  weight: 100)
     ]
     func getQuestionsCount() -> Int { questions.count }
     func getQuestion(weight: Int? = nil) -> Question? {
         let weight = weight ?? 0
         let questions = questions
             .filter { $0.weight > weight }
             .sorted(by: { $0.weight < $1.weight })
         guard let minWeight = questions.first?.weight else { return nil }
         return questions.filter { $0.weight == minWeight }.randomElement()
     }

     func getAnswersToHide(question: Question?) -> [Int] {
         guard let question = question else { return [] }
         var answers = question.answers
         answers.removeValue(forKey: question.validAnswerId)
         guard let key = answers.randomElement()?.key else { return [] }
         answers.removeValue(forKey: key)
         return answers.map { $0.key }
     }
 }
