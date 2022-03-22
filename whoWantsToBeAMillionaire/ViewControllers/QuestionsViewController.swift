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
    
    var questionSelectionStrategy: QuestionSelectionStrategy = .normal
    
    var newQuestionToAdd = Question(question: "", answers: [1 : "", 2 : "", 3 : "", 4 : ""], validAnswer: 1, weight: 100)
    
    let questionsSource = QuestionsSource()
    
    let totalQuestionNumberStorageValue: Double = 0
    
    //NotificationCenter
    var percentCount: Double = 0
    var theCount = 1
   
    private var question: Question?
         
    private var answerButtons: [Int: UIButton]?

    @IBOutlet weak var questionValueLabel: UILabel!
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    
    @IBOutlet weak var successPercentLabel: UILabel!
    
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

        questionsSource.appendNewQuestion()
        setButtons()
        delegate?.addTotalQuestions(count: questionsSource.getQuestionsCount())
        
        //NotificationCenter
        questionNumberLabel.text = "Question #" + String(theCount)
        successPercentLabel.text = "Success: 0%"
        
        //Self is this QuestionsViewController
        //Selector is a function that we call when the scenario happens
        //This function comes from ObjectiveC
        //Name is a name, it comes from Notificatons extension
        NotificationCenter.default.addObserver(self, selector: #selector(updateQuestionNumberLabel), name: .theCountDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSuccessPercentLabel), name: .percentCountDidChange, object: nil)
    
     }
    
     override func viewWillAppear(_ animated: Bool) {
        
        if questionSelectionStrategy == .normal {
            //Go through normal selection function
        question = questionsSource.getQuestion() } else {
            //Go through random selection function
        question = questionsSource.getQuestion2()
        }
        
        if !setQuestion(question: question) { exitGameSession() }
             print(questionSelectionStrategy)
         }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
      
        let totalQuestionNumberStorageValue = Double(questionsSource.getQuestionsCount())
        print("Total questions in database:",(questionsSource.getQuestionsCount()))
        print(totalQuestionNumberStorageValue)
        sleep(1)
           
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
         theCount = theCount + 1
         percentCount = percentCount + 1
         NotificationCenter.default.post(name: .theCountDidChange, object: nil)
         NotificationCenter.default.post(name: .percentCountDidChange, object: nil)
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
         if !setQuestion(question: question) {
            exitGameSession()
            }
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
            
    @objc func updateQuestionNumberLabel () {
       questionNumberLabel.text = "Question #" + String(theCount)
    }
   
    @objc func updateSuccessPercentLabel () {
       print(totalQuestionNumberStorageValue)
       //totalQuestionNumberStorageValue hardcoded to 11, because somehow it is lost between ViewWillApear and here
       //successPercentLabel.text = "Success: " + String(percentCount/totalQuestionNumberStorageValue*100) + "%"
       //format: "%.2f" is used to trim Double to 2 digits
       successPercentLabel.text = "Success: " + String(format: "%.2f", percentCount/11*100) + "%"
    }

}
