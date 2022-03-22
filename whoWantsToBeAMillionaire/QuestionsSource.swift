//
//  QuestionsSource.swift
//  whoWantsToBeAMillionaire
//
//  Created by Anton Lebedev on 09.03.2022.
//

import Foundation

class QuestionsSource {
    
//    var questionSelectionStrategy: QuestionSelectionStrategy
//    init(questionSelectionStrategy: QuestionSelectionStrategy) {
//        self.questionSelectionStrategy = questionSelectionStrategy
//
//    }
    
    
    //IMPORTANT: the questions' weight must be always increasing, you have to start array with minimum weight
    //and then increase weight from question to question. The weights can not be equal.
    //Otherwise it will not work properly.
    var questions = [
         Question(question: "The Sherlock Holmes' way of thinking, where the conclusions were derived from common to private, is called...",
                  answers: [1: "Deduction",
                            2: "Reduction",
                            3: "Induction",
                            4: "Reproduction"],
                  validAnswer: 1,
                  weight: 100),
         Question(question: "In economics, the good is characterized by the fact, that it is...",
                  answers: [1: "unlimited",
                            2: "limited",
                            3: "everywhere",
                            4: "produced"],
                  validAnswer: 2,
                  weight: 200),
         Question(question: "The Greek philosopher Xenophon's work about the housekeeping was called...",
                  answers: [1: "Chrematistics",
                            2: "Hoovephonicus",
                            3: "Xenophonicus",
                            4: "Oeconomicus"],
                  validAnswer: 4,
                  weight: 300),
         Question(question: "Mercantilism states, that the wealth of the country should best be measured in...",
                  answers: [1: "wheat bushels",
                            2: "wool",
                            3: "golden coins",
                            4: "education"],
                  validAnswer: 3,
                  weight: 400),
         Question(question: "In François Quesnay's Tableau Economique, who holds the money at the beginnig of the year?",
                  answers: [1: "producers",
                            2: "sterile class",
                            3: "landlords",
                            4: "clergy"],
                  validAnswer: 2,
                  weight: 500),
         Question(question: "Two Latin letters, that traditionally describe marginal costs, are...",
                  answers: [1: "MC",
                            2: "WC",
                            3: "FC",
                            4: "AC"],
                  validAnswer: 1,
                  weight: 600),
         Question(question: "In the process good's consumption, the marginal utility tends to be...",
                  answers: [1: "increasing",
                            2: "decreasing",
                            3: "constant",
                            4: "nil"],
                  validAnswer: 2,
                  weight: 700),
         Question(question: "A student has bought a bottle of cold tea for 50 cents and drank it dry. The bottle utility is 50 utils. What are the average costs per utility unit?",
                  answers: [1: "2 cents",
                            2: "1 cent",
                            3: "0.5 cents",
                            4: "50 cents"],
                  validAnswer: 2,
                  weight: 800),
         Question(question: "How much paper volumes does Das Kapital have?",
                  answers: [1: "3",
                            2: "4",
                            3: "5",
                            4: "6"],
                  validAnswer: 2,
                  weight: 900),
         Question(question: "The pensioner's marginal propensity to save is 0.9. What is the same pensioner's marginal propensity to consume?",
                  answers: [1: "0.1",
                            2: "1.0",
                            3: "0.9",
                            4: "9.0"],
                  validAnswer: 1,
                  weight: 1000)
     ]
    
     func getQuestionsCount() -> Int { questions.count }
    
     func appendNewQuestion() {
        questions.append(newQuestionToAdd)
     }
    
    
     func getQuestion() -> Question? {
        var questions = questions
        print(questions)
        return questions.first
     }
    
     func getQuestion2() -> Question? {
        var questions = questions.shuffled()
        print(questions)
        return questions.first
     }
     
     func removeFirstQuestion() {
        if !questions.isEmpty
        { questions.removeFirst() }
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
