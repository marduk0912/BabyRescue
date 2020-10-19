
//  MainMenu.swift
//  BabyRescue
//
//  Created by Fernando on 20/08/2020.
//  Copyright © 2020 Fernando Salvador. All rights reserved.
//

import SpriteKit
import GameplayKit

class MainMenu: SKScene {
    
    let label: SKLabelNode = SKLabelNode(fontNamed: "CHICORY")
    let label1: SKLabelNode = SKLabelNode(fontNamed: "CHICORY")
    var playableArea: CGRect
    
    override init(size: CGSize) {
        
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height - playableHeight)/2
        playableArea = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showBanner"), object: nil)
        
        var background: SKSpriteNode!
        background = SKSpriteNode(imageNamed: "Image14")
        background.position = CGPoint(x: playableArea.midX, y: playableArea.midY)
        background.zPosition = -10
        background.scale(to: CGSize(width: playableArea.width, height: playableArea.height))
        addChild(background)
        
        label.fontSize = 100
        label.fontColor = SKColor.black
        label.text = "TOUCH ME"
        label.zPosition = 100
        label.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        addChild(label)
        
        label1.fontSize = 75
        label1.fontColor = SKColor.black
        label1.text = "TO PLAY"
        label1.zPosition = 100
        label1.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2 - 200)
        label1.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        addChild(label1)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let scene = GameScene(size: size)
        scene.scaleMode = .aspectFill
        let revela = SKTransition.crossFade(withDuration: 0.5)
        view?.presentScene(scene, transition: revela)
    }

}
