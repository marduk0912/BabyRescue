//
//  WinScene.swift
//  BabyRescue
//
//  Created by Fernando on 30/08/2020.
//  Copyright © 2020 Fernando Salvador. All rights reserved.
//

import SpriteKit

class WinScene: SKScene {
    
    var win: Bool
    var lvl = 0
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    init(size: CGSize, win: Bool, lvl: Int){
        self.win = win
        super.init(size: CGSize(width: 2048, height: 1152))
        self.lvl = lvl
        scaleMode = .aspectFill
        
    }
    
   
    override func didMove(to view: SKView) {
       
        // Background
            let background = SKSpriteNode(imageNamed: "City\(lvl+1)")
            background.position = CGPoint(x: 0, y: 0)
            background.zPosition = -10
            background.scale(to: CGSize(width: 2048, height: 1152))
            background.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            
            addChild(background)
        
        // Set up labels
           let text = win ? "You Won 😃" : "Hola"
           let loseLabel = SKLabelNode(text: text)
           loseLabel.fontName = "04B30"
           loseLabel.fontSize = 100
           loseLabel.fontColor = .white
           loseLabel.position = CGPoint(x: frame.midX, y: frame.midY*1.5 - 90)
           addChild(loseLabel)

           let label = SKLabelNode(text: "Press anywhere to play level \(lvl+1)")
           label.fontName = "04B30"
           label.fontSize = 60
           label.fontColor = .white
           label.position = CGPoint(x: frame.midX, y: frame.midY - 150)
           addChild(label)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        switch lvl {
        case 1:
            let gameScene = GameScene1(size: size)
            let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.0)
            gameScene.scaleMode = .aspectFill
            view?.presentScene(gameScene, transition: transition)
        case 2:
            let gameScene = GameScene2(size: size)
            let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.0)
            gameScene.scaleMode = .aspectFill
            view?.presentScene(gameScene, transition: transition)
        case 3:
            let gameScene = GameScene3(size: size)
            let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.0)
            gameScene.scaleMode = .aspectFill
            view?.presentScene(gameScene, transition: transition)
        default:
            break
        }
        
        
       }
    
}
