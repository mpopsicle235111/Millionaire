
//
//  StartingScreenViewController.swift
//  whoWantsToBeAMillionaire
//
//  Created by Anton Lebedev on 10.03.2022.
//

import UIKit




class StartingScreenViewController: UIViewController {
    
    var selectedQuestionSelectionStrategy: QuestionSelectionStrategy = .normal
    var questionSelectionStrategy: QuestionSelectionStrategy = .normal
    var delegate: GameSessionDelegate?
       
    @IBAction func getResultsButton(_ sender: UIButton) {
//        didSet {
//                    getResultsButton.translatesAutoresizingMaskIntoConstraints = false
//                }
        resultsLabel.text = getResults()
    }
    
    @IBOutlet weak var resultsLabel: UITextView!
    
    
    @IBAction func startGameButton(_ sender: UIButton) {
        performSegue(withIdentifier: "startGameSegue", sender: sender)
    }
  
    @IBAction func gameSettingsButton(_ sender: UIButton) {
        performSegue(withIdentifier: "goChangeGameSettingsSegue", sender: sender)
    }
    
    
    override func viewDidLoad() {
        
        try? Game.instance.results = CareTaker<[GameSessionResult]>().load()
                     ?? [GameSessionResult]()
                 resultsLabel.text = getResults()
        
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "startGameSegue" {
                 guard let destinationVC = segue.destination
                     as? QuestionsViewController else { return }
                 if Game.instance.session == nil {
                    let session = GameSession()
                     Game.instance.session = session
                     destinationVC.delegate = session
                     //This line is added for question selection strategy
                     destinationVC.questionSelectionStrategy = self.selectedQuestionSelectionStrategy
                     print(selectedQuestionSelectionStrategy)
                 }
             }
        
      

    }
    private func getResults() -> String {
             return Game.instance.results.isEmpty ?
                 "No games were played" :
                 Game.instance.results
                 .map { $0.description() }
                 .reversed()
                 .joined(separator: "\n")
         }
}
