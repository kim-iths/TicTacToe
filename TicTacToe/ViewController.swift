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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...images.count-1 {
            images[i].isUserInteractionEnabled = true
            images[i].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(tgr:))))
        }
        
    }
    
    @objc func imageTapped(tgr: UITapGestureRecognizer) {
        let tappedImage = tgr.view as! UIImageView
        
        if isBlue {
            tappedImage.image = UIImage(named: "o")
            isBlue = false
        } else {
            tappedImage.image = UIImage(named: "x")
            isBlue = true
        }
        
    }
    
    
}
