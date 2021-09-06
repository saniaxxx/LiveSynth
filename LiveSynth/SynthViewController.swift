//
//  SynthViewController.swift
//  LiveSynth
//
//  Created by Serena on 1/13/19.
//  Copyright © 2019 Serena. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AudioKit


class SynthViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    if let view = self.view as! SKView? {
        
        if let scene = SKScene(fileNamed: "InfoScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            // Present the scene
            view.presentScene(scene)
        }
        view.ignoresSiblingOrder = true
        
        
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

