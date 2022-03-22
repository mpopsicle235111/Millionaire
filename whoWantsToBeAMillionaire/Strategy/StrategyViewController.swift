//
//  StrategyViewController.swift
//  whoWantsToBeAMillionaire
//
//  Created by Anton Lebedev on 15.03.2022.
//

import UIKit

// This protocol can be used a type.
protocol CreateQuestionSelectionStrategy {
    /// This is an open func inside the above type
    //We input "questions" array and return it back as Data array
    func sequence(from questions: [Question]) -> [Question]
}
//There are two selection strategies here: straightforward and random
//That is why Strategy is a behavioral pattern, because it's behavior (strategy) can change

final class NormalSequence: CreateQuestionSelectionStrategy {
    func sequence(from questions: [Question]) -> [Question] {
        print(questions)
        return questions
    }
}

final class RandomSequence: CreateQuestionSelectionStrategy {
    func sequence(from questions: [Question]) -> [Question] {
        var sortedQuestions = questions
        sortedQuestions.shuffle()
        return sortedQuestions
    }
}



class StrategyViewController: UIViewController {

    var selectionStrategy: CreateQuestionSelectionStrategy?

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    



}
