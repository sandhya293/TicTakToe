//
//  ViewController.swift
//  TicTacToe
//
//  Created by Sandhya Baghel on 03/07/21.
//  Copyright © 2021 Sandhya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let textfield:UITextField = {
        let text = UITextField()
        text.placeholder = " enter first player's name : "
        text.backgroundColor = UIColor.white
        return text
    }()
    private let image:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "tictactoe")
        return img
         }()
    private let textfield1:UITextField = {
        let text = UITextField()
        text.placeholder = " enter second player's name : "
        text.backgroundColor = UIColor.white
        return text
    }()
    private let button:UIButton = {
        let btn = UIButton()
        btn.setTitle("START GAME", for: .normal)
        btn.addTarget(self, action: #selector(btnclicked), for: .touchUpInside)
        btn.backgroundColor = UIColor.black
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(textfield)
         view.addSubview(textfield1)
         view.addSubview(button)
      //  view.addSubview(image)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textfield.frame = CGRect(x:30,y:300,width:350,height:50)
        textfield1.frame = CGRect(x:30,y:370,width:350,height:50)
        button.frame = CGRect(x:90,y:440,width:250,height:50)
       // image.frame = CGRect(x:0,y:0,width:550,height:950)
        
        title = "Login"
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back2")!)
    }
    @objc func btnclicked()
    {
            let vc = game()
        vc.player1 = textfield.text ?? ""
        vc.player2 = textfield1.text ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }

}

