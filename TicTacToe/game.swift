//
//  game.swift
//  TicTacToe
//
//  Created by Sandhya Baghel on 03/07/21.
//  Copyright © 2021 Sandhya. All rights reserved.
//

import Foundation

import UIKit

class game:UIViewController{
    
    private var state = [2,2,2,2,
                            2,2,2,2,
                            2,2,2,2,
                            2,2,2,2]
       
       private let winningCombinations = [[0, 1, 2,3], [4, 5, 6,7], [8, 9, 10,11], [12, 13,14,15], [0,5,10,15], [3,6,9,12], [0, 4, 8,12], [1,5,9,13] , [2,6,10,14], [3,7,11,15]]
       
       private var zeroFlag = false
       
       var player1:String =  ""
       var player2:String =  ""
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

  
    
    private let lbl:UILabel = {
        let label = UILabel()
       // label.text =  player1+"'s turn"
        label.textColor = UIColor.black
    
        return label
    }()
       private let myCollectionView:UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           layout.sectionInset = UIEdgeInsets(top: 90, left: 20, bottom: 20, right: 20)
           layout.itemSize = CGSize(width: 50, height: 50)
           
           
           let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
           collectionView.backgroundColor = .white
           return collectionView
       }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(myCollectionView)
         view.addSubview(lbl)
       setupCollectionView()
       // view.backgroundColor = UIColor(red: 0, green: 150, blue: 203, alpha: 1.0)
       //   view.backgroundColor = UIColorFromRGB(0x209624)
         self.view.backgroundColor = UIColor(patternImage: UIImage(named: "back2")!)
        lbl.text =  player1+"'s turn"
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        myCollectionView.frame = CGRect(x:50,y:200,width:300,height:400)
        lbl.frame = CGRect(x:135,y:120,width:150,height:50)
        
    }
}

extension game: UICollectionViewDataSource, UICollectionViewDelegate {
    
    private func setupCollectionView() {
        myCollectionView.register(gamecell.self, forCellWithReuseIdentifier: "gamecell")
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"gamecell", for: indexPath) as! gamecell
        cell.setupCell(with: state[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if state[indexPath.row] != 0 && state[indexPath.row] != 1 {
            state.remove(at: indexPath.row)
            
            if zeroFlag {
                state.insert(0, at: indexPath.row)
                lbl.text = player1+"'s turn"
            } else {
                state.insert(1, at: indexPath.row)
                 lbl.text = player2+"'s turn"
            }
            
            zeroFlag = !zeroFlag
            collectionView.reloadData()
            checkWinner()
        }
    }
    
    
    private func checkWinner() {
        
        if !state.contains(2) {
            let alert = UIAlertController(title: "Game over!", message: "Draw. Try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { [weak self] _ in
                self?.resetState()
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        for i in winningCombinations {
            if state[ i[0] ] == state[ i[1] ] && state[ i[1] ] == state[ i[2] ]  && state[ i[2] ] == state[ i[3] ] && state[ i[0] ] != 2 {
                announceWinner(player: state[ i[0] ] == 0 ? player2:  player1)
                break
            }
        }
    }
    
    private func announceWinner(player: String) {
        let alert = UIAlertController(title: "Game over!", message: "\(player) won", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { [weak self] _ in
            self?.resetState()
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func resetState() {
        state = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]
        zeroFlag = false
        myCollectionView.reloadData()
    }
}
