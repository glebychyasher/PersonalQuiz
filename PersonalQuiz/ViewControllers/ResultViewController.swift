//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Alexey Efimov on 07.08.2023.
//

import UIKit

final class ResultViewController: UIViewController {
    
    @IBOutlet weak var answerTitleLabel: UILabel!
    @IBOutlet weak var answerDescriptionLabel: UILabel!
    
    var answers: [Answer] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        if let result = getResult() {
            answerTitleLabel.text = "Вы - \(result.rawValue)!"
            answerDescriptionLabel.text = result.definition
        } else {
            answerTitleLabel.text = "Упс!"
            answerDescriptionLabel.text = "Произошла ошибка!"
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    deinit {
        print("\(type(of: self)) has been deallocated")
    }
}

//MARK: Function for the determination which animal is the user
extension ResultViewController {
    private func getResult() -> Animal?{
        var dict: [Animal: Int] = [:]
        for answer in answers {
            if let oldValue = dict[answer.animal]{
                dict.updateValue(oldValue + 1, forKey: answer.animal)
            } else {
                dict.updateValue(1, forKey: answer.animal)
            }
        }
        if let result = dict.max(by: {$0.value < $1.value})?.key {
            return result
        } else {
            return nil
        }
    }
}
