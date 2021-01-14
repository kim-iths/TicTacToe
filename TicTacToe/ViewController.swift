//
//  ViewController.swift
//  TicTacToe
//
//  Created by Kim Hellman on 2020-12-23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var turnIndicatorLabel: UILabel!
    @IBOutlet weak var stackViewH: UIStackView!
    
    @IBOutlet var images: [UIImageView]!
    
    var isBlue = true
    
    //list of possible winning combinations stored as arrays in an array
    let winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enableImagesInteraction(true)
                
        turnIndicatorLabel.textColor = UIColor.systemBlue

        //adds gesture recocgnizer for tapping each image
        for i in 0...images.count-1 {
            images[i].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(tgr:))))
        }
    }
    
    //called every time an image is pressed
    @objc func imageTapped(tgr: UITapGestureRecognizer) {
        let tappedImage = tgr.view as! UIImageView
        
        round += 1
        
        //determines which image to put in the selected tile
        if isBlue {
            tappedImage.image = UIImage(named: "o")
            isBlue = false
            turnIndicatorLabel.textColor = UIColor.systemRed
            turnIndicatorLabel.text = "Cross' turn"
        } else {
            tappedImage.image = UIImage(named: "x")
            isBlue = true
            turnIndicatorLabel.textColor = UIColor.systemBlue
            turnIndicatorLabel.text = "Circle's turn"
        }
        tappedImage.isUserInteractionEnabled = false
        
        for combo in 0...winningCombinations.count-1 {
            
            //checks if a winning combination contains the same images
            if images?[winningCombinations[combo][0]].image == images?[winningCombinations[combo][1]].image &&  images?[winningCombinations[combo][1]].image == images?[winningCombinations[combo][2]].image {
                
                var winner = "none"
                
                //checks if that combination contains a nil image, and if so, breaks the loop
                for i in 0...winningCombinations[combo].count-1 {
                    if images?[winningCombinations[combo][i]].image == nil {
                        break
                    } else if images?[winningCombinations[combo][i]].image == UIImage(named: "o") {
                        winner = "Circle"
                    } else {
                        winner = "Cross"
                    }
                }
                
                //if a winner is present, shows an alert
                if winner != "none" {
                    print(winner + " wins! \nWinning combination: " + String(combo))
                    displayAlert(winner)
                    
                    break
                }
            } else if round == 9 && combo == winningCombinations.count-1 { //if no one wins when the board is full, declare a tie
                print("It's a tie!")
                displayAlert("none")
                break
            }
        }
    }
    
    //function to display an alert when the game is over
    func displayAlert(_ winner: String){
        var alertText = "It's a tie!"
        if winner != "none" {
            alertText = winner + " wins!"
        }
        
        let alertController = UIAlertController(title: alertText, message: nil, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Restart", style: .default){_ in
            self.restartGame()
        })
        
        alertController.addAction(UIAlertAction(title: "Exit", style: .cancel){_ in
            
            self.performSegue(withIdentifier: "unwindToMenu", sender: self)
        })
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    //function that loops through all images and either disables or enables them
    func enableImagesInteraction(_ enabled: Bool){
        for i in 0...images.count-1 {
            images[i].isUserInteractionEnabled = enabled
        }
    }
    
    //function that restarts the game when called
    func restartGame(){
        for image in 0...images.count-1 {
            enableImagesInteraction(true)
            images[image].image = nil
            round = 0
            turnIndicatorLabel.textColor = UIColor.systemBlue
            turnIndicatorLabel.text = "Circle's turn"
            isBlue = true
        }
    }
}
