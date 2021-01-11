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
    
    //called every time a tile is pressed
    @objc func imageTapped(tgr: UITapGestureRecognizer) {
        let tappedImage = tgr.view as! UIImageView
        
        round += 1
        
        //determines which image to put in the selected tile
        if isBlue {
            tappedImage.image = UIImage(named: "o")
            isBlue = false
        } else {
            tappedImage.image = UIImage(named: "x")
            isBlue = true
        }
        tappedImage.isUserInteractionEnabled = false
        
        for combo in 0...winningCombinations.count-1 {
            
            
            //checks if a winning combination contains the same images
            if images?[winningCombinations[combo][0]].image == images?[winningCombinations[combo][1]].image &&  images?[winningCombinations[combo][1]].image == images?[winningCombinations[combo][2]].image {
                
                var winner = "none"
                
                //checks if that combination contains a nil image, and if so, breaks the loop
                comboLoop: for i in 0...winningCombinations[combo].count-1 {
                    if images?[winningCombinations[combo][i]].image == nil {
                        break
                    } else if images?[winningCombinations[combo][i]].image == UIImage(named: "o") {
                        winner = "Circle"
                    } else {
                        winner = "Cross"
                    }
                }
                
                //if a winner is present, prints the winner to the console
                if winner != "none" {
                    print(winner + " wins! \nWinning combination: " + String(combo))
                    enableImagesInteraction(false)
                }
            } else if round == 9 { //if no one ends when the board is full, declare a tie
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
