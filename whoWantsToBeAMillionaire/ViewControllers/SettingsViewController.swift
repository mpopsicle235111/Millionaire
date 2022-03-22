//
//  SettingsViewController.swift
//  whoWantsToBeAMillionaire
//
//  Created by Anton Lebedev on 20.03.2022.
//

import UIKit

var questions = [Question?].self

fileprivate var newQuestion = Question(question: "",
         answers: [1: "",
                   2: "",
                   3: "",
                   4: ""],
         validAnswer: 2,
         weight: 200)

var newQuestionToAdd = Question(question: "Added Extra Hardcoded Question",
         answers: [1: "Right Answer 1",
                   2: "WrongAnswer2",
                   3: "WrongAnswer3",
                   4: "WrongAnswer4"],
         validAnswer: 1,
         weight: 100)

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var questionTextInput: UITextView!
    
    @IBOutlet weak var answer1Input: UITextField!
    
    @IBOutlet weak var answer2Input: UITextField!
    
    @IBOutlet weak var answer3Input: UITextField!
    
    @IBOutlet weak var answer4Input: UITextField!
    
    @IBOutlet weak var correctAnswerNumberInput: UITextField!
    
    @IBOutlet weak var questionWeightInput: UITextField!
    
    @IBOutlet weak var submitNewQuestionButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func saveChangesAndExitButton(_ sender: UIButton) { performSegue(withIdentifier: "saveChangesAndStartGame", sender: sender)
    }
    
    
    @IBAction func goBackToStartingScreenButton(_ sender: UIButton) { performSegue(withIdentifier: "goBackToStartingScreen", sender: sender)
    }
    
    //These variables are added for question selection strategy
    @IBOutlet weak var questionSelectionStrategyControl: UISegmentedControl!
    
    
    @IBAction func submitNewQuestionButtonPressed(_ sender: UIButton) {
        
        //We get various text fields from user
        let questionText = questionTextInput.text!
        let answer1 = answer1Input.text!
        let answer2 = answer2Input.text!
        let answer3 = answer3Input.text!
        let answer4 = answer4Input.text!
        let correctAnswerNumber = correctAnswerNumberInput.text!
        let weightToSet = questionWeightInput.text!
        
        print("Question text: \(questionText)")
        print("Answer 1: \(answer1)")
        print("Answer 2: \(answer2)")
        print("Answer 3: \(answer3)")
        print("Answer 4: \(answer4)")
        print("Correct answer number: \(correctAnswerNumber)")
        print("Question weight: \(weightToSet)")
        
        if (questionText.isEmpty == false) && (answer1.isEmpty == false) && (answer2.isEmpty == false) && (answer3.isEmpty == false) && (answer4.isEmpty == false) && (correctAnswerNumber.isEmpty == false) && (weightToSet.isEmpty == false) {
            print("QUESTION SUBMITTED")
            let newQuestion = Question(question: questionText,
                     answers: [1: answer1,
                               2: answer2,
                               3: answer3,
                               4: answer4],
                     validAnswer: Int(correctAnswerNumber) ?? 1,
                     weight: Int(weightToSet) ?? 0)
            print(newQuestion)
            sleep(3)
            let newQuestionToAdd = newQuestion
            performSegue(withIdentifier: "saveChangesAndStartGame", sender: newQuestionToAdd)
            }  else {
            //UIAlertController is a class that shows messages to user
            //Let's warn user, that some data is missing
            //Otherwise the user can decide, that our app froze
            //And we have to be concerned with user's satisfaction
                
            let alert = UIAlertController(title: "ERROR", message: "SOME DATA IS MISSING", preferredStyle: .alert)
            //We create th special button for UIAlertcontroller
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            //and add this button to UIAlertcontroller
            alert.addAction(action)
            //Now we can show UIAlertController
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    var selectedQuestionSelectionStrategy: QuestionSelectionStrategy {
        switch self.questionSelectionStrategyControl.selectedSegmentIndex {
        case 0:
            return .normal
        case 1:
            return .random
        default:
            return .normal
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accessVariable()
        
        //Let us add tap gesture to scrollView
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(hideKeyboardGesture)

        
    }
    
    //This func subscribes to the NotificationCenter messages sent by the keyboard
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //We are subscribint to 2 notifications: the first comes when keyboard appears
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        //The second comes when keyboard will hide
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        accessVariable()
    }
    
    //The textbook rule is to unsubscribe from unnecessary notifications
    //This func unsubsribes from notifications, whe this controller is no longer on the screen
    override func viewWillDisappear (_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func accessVariable() {
       print("\(newQuestion)")
    }
    
    //When keyboard appears
    @objc func keyboardWasShown(notification: Notification) {
        
        //we get the keyboard size
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        print(kbSize.height)
        
        //We add the bottom inlet with the size of the keyboard
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    
    //When the keyboard will be hidden
    @objc func keyboardWillBeHidden (notification: Notification) {
        //We setup zero inset at the bottom
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    //This func hides the keyboard if we tap an empty space on screen
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "saveChangesAndStartGame" {
                 guard let destinationVC = segue.destination
                     as? QuestionsViewController else { return }
                 if Game.instance.session == nil {
                    let session = GameSession()
                     Game.instance.session = session
                     destinationVC.delegate = session
                     //This line is added for question selection strategy
                     destinationVC.questionSelectionStrategy = self.selectedQuestionSelectionStrategy
                     let newQuestionToAdd = newQuestion
                     destinationVC.newQuestionToAdd = newQuestionToAdd
                     print(selectedQuestionSelectionStrategy)
                     print(newQuestionToAdd)
                     sleep(2)
                 }
             }
        
      

    }
    
    

}
