//
//  GameViewController.swift
//  BabyRescue
//
//  Created by Fernando on 19/08/2020.
//  Copyright © 2020 Fernando Salvador. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds

class GameViewController: UIViewController {


    @IBOutlet weak var banner: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if let view = self.view as! SKView? {
        let scene = MainMenu(size: CGSize(width: 2048, height: 1152))
        let view = self.view as! SKView
        scene.scaleMode = .aspectFill
                
        // Present the scene
        view.presentScene(scene)
   
        view.ignoresSiblingOrder = true
            
        view.showsFPS = true
        view.showsNodeCount = true
    
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        banner.rootViewController = self
        banner.load(GADRequest())
        
        NotificationCenter.default.addObserver(self, selector: #selector(showAdmodBanner), name: NSNotification.Name(rawValue: "showBanner"), object: nil)
        
     
  
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func showAdmodBanner(){
        self.banner.isHidden = false
       }
}
