//
//  QuestionsViewController.swift
//  whoWantsToBeAMillionaire
//
//  Created by Anton Lebedev on 10.03.2022.
// Line added for making a commit
// Line added for making a commit

import UIKit

protocol QuestionsViewControllerDelegate: AnyObject {
     func endGame(totalScore: Int)
 }

class QuestionsViewController: UIViewController {
    
    var delegate: GameSessionDelegate?
  
    
    let questionsSource = QuestionsSource()
    
    var selectionStrategy: SelectionStrategy = .normal
    
    private var questionSelectionStrategy: QuestionSelectionStrategy {
        switch self.selectionStrategy {
        case .normal:
            return NormalSelection()
        case .random:
            return RandomSelection()
        }
    }
   
    private var question: Question?
         
    private var answerButtons: [Int: UIButton]?

    @IBOutlet weak var questionValueLabel: UILabel!
    
    @IBOutlet weak var questionTextView: UITextView!
    
    @IBOutlet weak var currentScoreLabel: UILabel!
         
    @IBOutlet weak var answerButtonD: UIButton!
    
    @IBOutlet weak var answerButtonC: UIButton!
         
    @IBOutlet weak var answerButtonB: UIButton!
         
    @IBOutlet weak var answerButtonA: UIButton!
         
    @IBOutlet weak var audienceHelpButton: UIButton!
    
    @IBOutlet weak var callFriendButton: UIButton!
    
    @IBOutlet weak var hideWrongAnswersButton: UIButton!
    

    @IBAction func hideWrongAnswersAction(_ sender: UIButton) {
        sender.isEnabled = false
        delegate?.useHint(hintType: .hideInvalids)
        hideAnswers(buttonId: questionsSource.getAnswersToHide(question: question))
    }

    @IBAction func callFriendAction(_ sender: UIButton) {
        sender.isEnabled = false
        delegate?.useHint(hintType: .callFriend)
    }
    
    @IBAction func audienceHelpAction(_ sender: UIButton) {
        sender.isEnabled = false
        delegate?.useHint(hintType: .audienceHelp)
    }
   


    @IBAction func buttonD(_ sender: UIButton) {
        checkAnswer(button: sender)
    }
    
    @IBAction func buttonC(_ sender: UIButton) {
        checkAnswer(button: sender)
    }
    
    @IBAction func buttonB(_ sender: UIButton) {
        checkAnswer(button: sender)
    }
    
    @IBAction func buttonA(_ sender: UIButton) { checkAnswer(button: sender) }



    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setButtons()
        delegate?.addTotalQuestions(count: questionsSource.getQuestionsCount())
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
             question = questionsSource.getQuestion()
             if !setQuestion(question: question) { exitGameSession() }
             //print(questionSelectionStrategy)
         }

         private func hideAnswers(buttonId: [Int]?) {
             if let answerButtons = answerButtons,
                let buttonId = buttonId
             {
                 buttonId.forEach {
                     if let button = answerButtons[$0] { button.isHidden = true }
                 }
             }
         }

         private func checkAnswer(button: UIButton) {
             let currentQuestion = question
             question = nil
             if let id = currentQuestion?.validAnswerId,
                let validButton = answerButtons?[id]
             {
                 if button === validButton {
                     delegate?.addAnsweredQuestion(weight: currentQuestion?.weight)
                     //After the question is used, we remove if from the array of questions
                     questionsSource.removeFirstQuestion()
                     //We get a question from the array to be displayed
                     //This actually happens before we remove the above mentioned question
                     question = questionsSource.getQuestion()
                     
                 }
             }
             if !setQuestion(question: question) { exitGameSession() }
         }

         private func exitGameSession() {
             Game.instance.calculateResults()
             dismiss(animated: true,
                     completion: nil)
         }

         private func setQuestion(question: Question?) -> Bool {
             guard let question = question else {
                 return false
             }
             questionTextView.text = question.questionText
             currentScoreLabel.text = "Score \(delegate?.getSum() ?? 0)"
             questionValueLabel.text = "Question price \(question.weight)"
             answerButtons?.forEach {
                 $0.value.setTitle(question.answers[$0.key], for: .normal)
                 $0.value.isHidden = false
                 $0.value.isEnabled = true
             }
             return true
         }

         private func setButtons() {
             answerButtons = [1: answerButtonA,
                              2: answerButtonB,
                              3: answerButtonC,
                              4: answerButtonD]
             hideWrongAnswersButton.setImage(UIImage(named: "50"),
                                             for: .normal)
             hideWrongAnswersButton.setImage(UIImage(named: "checkbox"),
                                             for: .disabled)
             audienceHelpButton.setImage(UIImage(named: "people"),
                                         for: UIControl.State.normal)
             audienceHelpButton.setImage(UIImage(named: "checkbox"),
                                         for: UIControl.State.disabled)
             callFriendButton.setImage(UIImage(named: "call"),
                                       for: UIControl.State.normal)
             callFriendButton.setImage(UIImage(named: "checkbox"),
                                       for: UIControl.State.disabled)
             hideWrongAnswersButton.isEnabled = true
             audienceHelpButton.isEnabled = true
             callFriendButton.isEnabled = true
         }
    
    
    
            
    

}
