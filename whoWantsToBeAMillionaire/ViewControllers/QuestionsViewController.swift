//
//  QuestionsViewController.swift
//  whoWantsToBeAMillionaire
//
//  Created by Anton Lebedev on 10.03.2022.
//

import UIKit

protocol QuestionsViewControllerDelegate: AnyObject {
     func endGame(totalScore: Int)
 }

class QuestionsViewController: UIViewController {
    
    var delegate: GameSessionDelegate?
         
    private let questionsSource = QuestionsSource()
         
    private var question: Question?
         
    private var answerButtons: [Int: UIButton]?

         
    @IBOutlet var questionValueLabel: UILabel!
         
    @IBOutlet var questionLabel: UILabel!
         
    @IBOutlet var currentScoreLabel: UILabel!
         
    @IBOutlet var answerButtonD: UIButton!
         
    @IBOutlet var answerButtonC: UIButton!
         
    @IBOutlet var answerButtonB: UIButton!
         
    @IBOutlet var answerButtonA: UIButton!
         
    @IBOutlet var audienceHelpButton: UIButton!
         
    @IBOutlet var callFriendButton: UIButton!
         
    @IBOutlet var hideWrongAnswersButton: UIButton!
    
    @IBAction func hideWrongAnswersAction(_ sender: UIButton) {
             sender.isEnabled = false
             delegate?.useHint(hintType: .hideInvalids)
             hideAnswers(buttonId: questionsSource.getAnswersToHide(question: question))
         }


         
    @IBAction func callButton(_ sender: UIButton) {
             sender.isEnabled = false
             delegate?.useHint(hintType: .callFriend)
         }

         
    @IBAction func audienceHelpButton(_ sender: UIButton) {
             sender.isEnabled = false
             delegate?.useHint(hintType: .audienceHelp)
         }

         
    @IBAction func buttonD(_ sender: UIButton) { checkAnswer(button: sender) }

         
    @IBAction func buttonC(_ sender: UIButton) { checkAnswer(button: sender) }

         
    @IBAction func buttonB(_ sender: UIButton) { checkAnswer(button: sender) }

         
    @IBAction func buttonA(_ sender: UIButton) { checkAnswer(button: sender) }

    override func viewDidLoad() {
        super.viewDidLoad()

        setButtons()
        delegate?.addTotalQuestions(count: questionsSource.getQuestionsCount())
    }
    
    override func viewWillAppear(_ animated: Bool) {
             question = questionsSource.getQuestion()
             if !setQuestion(question: question) { exitGameSession() }
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
                     question = questionsSource.getQuestion(weight: currentQuestion?.weight)
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
             questionLabel.text = question.questionText
             currentScoreLabel.text = "Выигрыш \(delegate?.getSum() ?? 0)"
             questionValueLabel.text = "Цена вопроса \(question.weight)"
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
