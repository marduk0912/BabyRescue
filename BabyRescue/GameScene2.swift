//
//  GameScene2.swift
//  BabyRescue
//
//  Created by Fernando on 19/08/2020.
//  Copyright © 2020 Fernando Salvador. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene2: SKScene, SKPhysicsContactDelegate {
    
    var background: SKSpriteNode!
    var player: SKSpriteNode!
    let playerCategory: UInt32 = 1<<1
    let cachorroCategory: UInt32 = 1<<2
    let bombaCategory: UInt32 = 1<<3
    
    let liveLabel: SKLabelNode = SKLabelNode(fontNamed: "04B30")
    let scoreLabel: SKLabelNode = SKLabelNode(fontNamed: "04B30")
    
    var lives = 5
    var score = 0
    
    var playableArea: CGRect
    
    override init(size: CGSize) {
       // Define playable area
       let maxAspectRatio: CGFloat = 16.0/9.0
       let playableHeight = size.width / maxAspectRatio
       let playableMargin = (size.height - playableHeight)/2
       playableArea = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
           
       super.init(size: size)
        
        addObserver()
       }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didMove(to view: SKView) {
           
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showBanner"), object: nil)
            
            physicsWorld.contactDelegate = self
            
            initBackground()
            initPlayer()
            initFonts()
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addEscombro), SKAction.wait(forDuration: 0.7)])))
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addCachorro), SKAction.wait(forDuration: 3.0)])))
        }
    
    override func update(_ currentTime: TimeInterval) {
         liveLabel.text = "LIVES  \(lives)"
         scoreLabel.text = "SCORE  \(score)/20"
    }
    
    func initFonts(){
        
        liveLabel.fontColor = SKColor.black
        liveLabel.fontSize = 75
        liveLabel.zPosition = 50
        liveLabel.text = "LIVES  \(lives)"
        liveLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        liveLabel.position = CGPoint(x: 250, y: frame.size.height - 200)
        addChild(liveLabel)
        
        scoreLabel.fontColor = SKColor.black
        scoreLabel.fontSize = 75
        scoreLabel.zPosition = 50
        scoreLabel.text = "SCORE  \(score)/20"
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.right
        scoreLabel.position = CGPoint(x: frame.size.width - 300 , y: frame.size.height - 200)
        addChild(scoreLabel)
        
    }
    
    func initBackground(){
        background = SKSpriteNode(imageNamed: "City3")
        background.position = CGPoint(x: playableArea.midX, y: playableArea.midY)
        background.zPosition = -10
        background.scale(to: CGSize(width: playableArea.width, height: playableArea.height))
        addChild(background)
    }
    
    func initPlayer(){
        player = SKSpriteNode(imageNamed: "player0")
        player.position = CGPoint(x: playableArea.midX, y: playableArea.minY + 300)
        player.zPosition = 0
        addChild(player)
        
        player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: player.size.width/2, height: player.size.height/2))
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.allowsRotation = false
        
       var texture: [SKTexture] = []
       for i in 0...1{
                  texture.append(SKTexture(imageNamed: "player\(i)"))
              }
        
        
        
        var playerAnimation: SKAction!
        playerAnimation = SKAction.animate(with: texture, timePerFrame: 0.2)
        player.run(SKAction.repeatForever(playerAnimation))
        player.isPaused = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        player.isPaused = false
        if player.position.x > touchLocation.x{
            player.run(SKAction.scaleX(to: -1, duration: 0.1))
        }else{
            player.run(SKAction.scaleX(to: 1, duration: 0.1))
        }
        let xDis = player.position.x - touchLocation.x
        let yDis = player.position.y - touchLocation.y
        let distancia = sqrt((xDis * xDis) + (yDis * yDis))
        let speed: CGFloat = 1100.0
        let duracion: CGFloat = distancia/speed
        
        player.run(SKAction.moveTo(x: touchLocation.x, duration: TimeInterval(duracion)))
        }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
         let touch = touches.first
               let touchLocation = touch!.location(in: self)
               
               player.isPaused = false
               if player.position.x > touchLocation.x{
                   player.run(SKAction.scaleX(to: -1, duration: 0.1))
               }else{
                   player.run(SKAction.scaleX(to: 1, duration: 0.1))
               }
               let xDis = player.position.x - touchLocation.x
               let yDis = player.position.y - touchLocation.y
               let distancia = sqrt((xDis * xDis) + (yDis * yDis))
               let speed: CGFloat = 1100.0
               let duracion: CGFloat = distancia/speed
         player.run(SKAction.moveTo(x: touchLocation.x, duration: TimeInterval(duracion)))
    }
    
    func addCachorro() {
         
         var cachorroTexture:[SKTexture] = []
     
         for i in 1...3 {
             cachorroTexture.append(SKTexture(imageNamed: "dog\(i)"))
         }
     
    
         let animacionCachorro = SKAction.animate(with: cachorroTexture, timePerFrame: 0.3)
         let cachorroCayendo = SKAction.repeatForever(animacionCachorro)
           
         let cachorro = SKSpriteNode(texture: cachorroTexture[0])
         cachorro.run(cachorroCayendo)
         cachorro.xScale = 0.5
         cachorro.yScale = 0.5
         cachorro.position = CGPoint(x: CGFloat.random(min: 0, max: size.width - cachorro.size.width/2), y: size.height + cachorro.size.height/2)
        cachorro.zPosition = -1
         addChild(cachorro)
        
        cachorro.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: cachorro.size.width/2, height: cachorro.size.height/2))
        cachorro.physicsBody?.collisionBitMask = 0
        cachorro.physicsBody?.categoryBitMask = cachorroCategory
        cachorro.physicsBody?.contactTestBitMask = playerCategory
        cachorro.physicsBody?.affectedByGravity = false
        cachorro.physicsBody?.allowsRotation = false
         
     
        let actionMove = SKAction.move(to: CGPoint(x: cachorro.position.x, y: -cachorro.size.height/2 - size.height/2), duration: 3.5)
         let eliminarCachorro = SKAction.removeFromParent()
     
        cachorro.run(SKAction.repeatForever(SKAction.sequence([actionMove, eliminarCachorro])))
       
       }
    
    func addEscombro() {
         
        
        var escombroTexture:[SKTexture] = []
          
        for i in 0...3 {
            escombroTexture.append(SKTexture(imageNamed: "Prop\(i)"))
        }
          
         
        let animacionEscombro = SKAction.animate(with: escombroTexture, timePerFrame: 0.05)
        let escombroCayendo = SKAction.repeatForever(animacionEscombro)
                
        let escombro = SKSpriteNode(texture: escombroTexture[0])
        escombro.run(escombroCayendo)
        escombro.xScale = 0.5
        escombro.yScale = 0.5
        escombro.position = CGPoint(x: CGFloat.random(min: 0, max: size.width - escombro.size.width/2), y: size.height + escombro.size.height/2)
        escombro.zPosition = -1
         addChild(escombro)
        
        escombro.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: escombro.size.width/2, height: escombro.size.height/2))
        escombro.physicsBody?.collisionBitMask = 0
        escombro.physicsBody?.categoryBitMask = bombaCategory
        escombro.physicsBody?.contactTestBitMask = playerCategory
        escombro.physicsBody?.affectedByGravity = false
        escombro.physicsBody?.allowsRotation = false
         
     
        let actionMove = SKAction.move(to: CGPoint(x: escombro.position.x, y: -escombro.size.height/2 - size.height/2), duration: 3.5)
        let eliminarEscombro = SKAction.removeFromParent()
     
        escombro.run(SKAction.repeatForever(SKAction.sequence([actionMove, eliminarEscombro])))
       
       }
   
    func didBegin(_ contact: SKPhysicsContact) {
        
        let contact = contact.bodyA.categoryBitMask == playerCategory ? contact.bodyB : contact.bodyA
        
        if contact.categoryBitMask == cachorroCategory{
            score += 1
            removeObj(contacto: contact)
            newScene()
        }else{
            lives -= 1
            removeObj(contacto: contact)
            shakeCamera(duration: 5.0)
            
            if lives == 0{
                let gameOver = GameOver(size: size)
                gameOver.scaleMode = scaleMode
                let show = SKTransition.fade(with: .black, duration: 2.0)
                view?.presentScene(gameOver, transition: show)
            }
        }
    }
    
    func removeObj(contacto: SKPhysicsBody){
        player.run(SKAction.sequence([SKAction.wait(forDuration: 0.1), SKAction.run(contacto.node!.removeFromParent)]))
    }
    
    func shakeCamera(duration: CGFloat){
        
        let amplitudeX: CGFloat = 20
        let amplitudeY: CGFloat = 20
        let numberOfShake = duration/0.4
        var actionArray: [SKAction] = []
        
        for _ in 1...Int(numberOfShake){
            let moveX = CGFloat(arc4random_uniform(UInt32(amplitudeX))) - amplitudeX/2;
            let moveY = CGFloat(arc4random_uniform(UInt32(amplitudeY))) - amplitudeY/2;
            let shakeAction = SKAction.moveBy(x: moveX, y: moveY, duration: 0.02);
            shakeAction.timingMode = SKActionTimingMode.easeOut;
            actionArray.append(shakeAction);
            actionArray.append(shakeAction.reversed());
        }
        let actionSeq = SKAction.sequence(actionArray);
        background.run(actionSeq)
    }
    
    func youWin(){
        let winScene = WinScene(size: size, win: true, lvl: 3)
        let transition = SKTransition.doorway(withDuration: 0.3)
        view?.presentScene(winScene, transition: transition)
    }
    
    func newScene (){
        if score == 20 {
            youWin()
        }
    }
       
}

extension GameScene2{
    @objc func applicationDidBecomeAvctive(){
        self.isPaused = true
        print("* applicationDidBecomeActive")
    }
    @objc func applicationWillResignActive(){
        self.isPaused = true
        print("* applicationWillResignActive")
    }
    @objc func applicationDidEnterBackground(){
        self.isPaused = true
        print("* applicationDidEnterBackground")
    }
   
    func addObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeAvctive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
    }
}
    
