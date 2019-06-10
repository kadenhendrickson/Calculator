//
//  CalculatorViewController.swift
//  BetterCalculator
//
//  Created by Kaden Hendrickson on 6/10/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var image: UIImage?
    
    var numberOnScreen: Double = 0.0
    var previousNumber: Double = 0.0
    var performingMath = false
    var operation = 0
    
    let goodMessages = ["Wow, you look really good today!", "DAMN baby girl, work it", "LOVE your outfit queen", "slayyyy boi! get it!", "Wowza! Who's that cutie?!"]
    let badMessges = ["Dear god did you even brush your hair?", "Wow, you look absolutely awful", "Go die you worthless shit", "hm, yeah you should not go out like that", "I don't like what I see..."]
    
    @IBAction func number(_ sender: UIButton) {
        if performingMath {
            totalTextLabel.text = String(sender.tag-1)
            numberOnScreen = Double(totalTextLabel.text!)!
            performingMath = false
        } else {
            totalTextLabel.text = totalTextLabel.text! + String(sender.tag-1)
            numberOnScreen = Double(totalTextLabel.text!)!
        }
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        if totalTextLabel.text != "" && sender.tag != 11 && sender.tag != 16 {
            previousNumber = Double(totalTextLabel.text!)!
            
            switch sender.tag {
            case 12:
                totalTextLabel.text = "/"
            case 13:
                totalTextLabel.text = "*"
            case 14:
                totalTextLabel.text = "-"
            case 15:
                totalTextLabel.text = "+"
            default:
                totalTextLabel.text = ""
            }
            operation = sender.tag
            performingMath = true
        }
        
        else if sender.tag == 16 {
            
            switch operation {
            case 12:
                totalTextLabel.text = String(previousNumber/numberOnScreen)
            case 13:
                totalTextLabel.text = String(previousNumber*numberOnScreen)
            case 14:
                totalTextLabel.text = String(previousNumber-numberOnScreen)
            case 15:
                totalTextLabel.text = String(previousNumber+numberOnScreen)
            default:
                totalTextLabel.text = ""
            }
        }
        else if sender.tag == 11 {
            totalTextLabel.text = ""
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
        }
        else if sender.tag == 17 {
            totalTextLabel.text = goodMessages.randomElement()
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
        }
        else if sender.tag == 18 {
            totalTextLabel.text = badMessges.randomElement()
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
        }
    }
    
    
    @IBOutlet weak var totalTextLabel: UILabel!
    @IBOutlet weak var calculatorImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorImageView.image = image
       
            }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchImage { (success) in
            if success {
                DispatchQueue.main.async {
                    self.loadView()
                }
            }
        }
    }
    
    func fetchImage(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://picsum.photos/200") else {return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("😝 There was an error in \(#function) : \(error) : \(error.localizedDescription) 😝")
                completion(false)
                return
            }
            guard let data = data else {return}
            let image = UIImage(data: data)
            self.image = image
            completion(true)
        }
    }
}
