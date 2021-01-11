//
//  ViewController.swift
//  TicTacToe
//
//  Created by Kim Hellman on 2020-12-23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var stackViewH: UIStackView!
    
    @IBOutlet var images: [UIImageView]!
    
    var isBlue = true
    
    let winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableImagesInteraction(true)
        
        for i in 0...images.count-1 {
            images[i].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(tgr:))))
        }
        
    }
    
    @objc func imageTapped(tgr: UITapGestureRecognizer) {
        let tappedImage = tgr.view as! UIImageView
        
        round += 1
        
        if isBlue {
            tappedImage.image = UIImage(named: "o")
            isBlue = false
        } else {
            tappedImage.image = UIImage(named: "x")
            isBlue = true
        }
        tappedImage.isUserInteractionEnabled = false
        
        for combo in 0...winningCombinations.count-1 {
            
            if images?[winningCombinations[combo][0]].image == images?[winningCombinations[combo][1]].image &&  images?[winningCombinations[combo][1]].image == images?[winningCombinations[combo][2]].image {
                
                var winner = "none"
                
                comboLoop: for i in 0...winningCombinations[combo].count-1 {
                    if images?[winningCombinations[combo][i]].image == nil {
                        break
                    } else if images?[winningCombinations[combo][i]].image == UIImage(named: "o") {
                        winner = "Circle"
                    } else {
                        winner = "Cross"
                    }
                }
                
                if winner != "none" {
                    print(winner + " wins! \nWinning combination: " + String(combo))
                    enableImagesInteraction(false)
                }
            } else if round == 9 {
                print("It's a tie!")
                break
            }
        }
    }
    
    func enableImagesInteraction(_ enabled: Bool){
        for i in 0...images.count-1 {
            images[i].isUserInteractionEnabled = enabled
        }
        
    }
    
}
