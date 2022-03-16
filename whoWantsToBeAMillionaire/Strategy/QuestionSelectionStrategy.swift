//
//  QuestionSelectionStrategy.swift
//  whoWantsToBeAMillionaire
//
//  Created by Anton Lebedev on 15.03.2022.
//

import Foundation


// This protocol can be used a type.
protocol QuestionSelectionStrategy: AnyObject {
    var questions: [Question]? { get set }
    func setSequence()
}
//There are two selection strategies here: straightforward and random
//That is why Strategy is a behavioral pattern, because it's behavior (strategy) can change

final class NormalSelection: QuestionSelectionStrategy {
    var questions: [Question]?
    func setSequence()  { }
    }


final class RandomSelection: QuestionSelectionStrategy {
    var questions: [Question]?
    var sortedQUestions: [Question]?
    func setSequence()  {
        guard var questions = questions else { return }
        //var sortedQuestions = questions
        questions.shuffle()
        //questions = sortedQuestions
    }
}
