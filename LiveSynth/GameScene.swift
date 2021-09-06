//
//  GameScene.swift
//  LiveSynth
//
//  Created by Serena on 11/9/18.
//  Copyright © 2018 Serena. All rights reserved.
//
import UIKit
import SpriteKit
import GameplayKit
import AudioKit
class GameScene: SKScene {
    
    //Label variable is initialised
    let myLabel = SKLabelNode(fontNamed:"Futura-MediumItalic")
    
    override func didMove(to view: SKView) {
        
            //Here a shape is initialised and set to be a rectangle with rounded edges. This forms part of the LiveSynth logo
            let shape = SKShapeNode()
            shape.path = UIBezierPath(roundedRect: CGRect(x: -45, y:210, width:300, height: 50), cornerRadius: 12).cgPath
            shape.position = CGPoint(x: frame.midX, y: frame.midY)
            //The colours are set using RGB values
            shape.fillColor = UIColor(red: 0.25,green: 0.55,blue: 1.0, alpha: 1.0)
            shape.strokeColor = UIColor(red: 1.0,green: 1.0,blue: 1.0, alpha: 1.0)
            shape.lineWidth = 3
            //The shape is then added to the scene
            self.addChild(shape)
        
            //Here the text for the LiveSynth Logo is initialised
            myLabel.text = "LiveSynth";
            myLabel.fontSize = 30
            //The position is set to be in the middle of the above shape
            myLabel.position = CGPoint(x: shape.frame.midX, y: shape.frame.midY-10)
            myLabel.fontColor = UIColor.black
            //The label is then added to the scene
            self.addChild(myLabel)
  
}

}


