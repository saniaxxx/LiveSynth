//
//  InfoScreen.swift
//  LiveSynth
//
//  Created by Serena Badesha on 1/15/19.
//  Copyright © 2019 Serena. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

//This class is used to set the shapes and text for the information scene
class InfoScene: SKScene {
    
   
    let logo = SKLabelNode(fontNamed:"Futura-MediumItalic")
    let myLabelWelc = SKLabelNode(fontNamed:"Futura-Medium")
    let seqInfo = SKLabelNode(fontNamed:"Futura-Medium")
    let keyboardInfo = SKLabelNode(fontNamed:"Futura-Medium")
    let FxsInfo = SKLabelNode(fontNamed:"Futura-Medium")
    
    
    override func didMove(to view: SKView) {

        //Shape behind logo
        let shapeRect = SKShapeNode()
        shapeRect.path = UIBezierPath(roundedRect: CGRect(x: -55, y:210, width:300, height: 50), cornerRadius: 12).cgPath
        shapeRect.position = CGPoint(x: frame.midX, y: frame.midY)
        //The colours are set using RGB values
        shapeRect.fillColor = UIColor(red: 0.25,green: 0.55,blue: 1.0, alpha: 1.0)
        shapeRect.strokeColor = UIColor(red: 1.0,green: 1.0,blue: 1.0, alpha: 1.0)
        shapeRect.lineWidth = 3
        //The shape is then added to the scene
        self.addChild(shapeRect)
        
        //Logo
        logo.text = "LiveSynth";
        logo.fontSize = 30
        //The position is set to be in the middle of the above shape
        logo.position = CGPoint(x: shapeRect.frame.midX, y: shapeRect.frame.midY-10)
        logo.fontColor = UIColor.black
        self.addChild(logo)
  
        //Welcome text
        myLabelWelc.text = "Welcome to ";
        myLabelWelc.fontSize = 30
        myLabelWelc.position = CGPoint(x: -200, y: 225)
        myLabelWelc.fontColor = UIColor.black
        self.addChild(myLabelWelc)
        
        //Shape with information about sequencer
        let shapeRectSeq = SKShapeNode()
        shapeRectSeq.path = UIBezierPath(roundedRect: CGRect(x: -348, y:-5, width:265, height: 100), cornerRadius: 12).cgPath
        shapeRectSeq.position = CGPoint(x: frame.midX, y: frame.midY)
        //The colours are set using RGB values
        shapeRectSeq.fillColor = UIColor(red: 0.25,green: 0.55,blue: 1.0, alpha: 1.0)
        shapeRectSeq.strokeColor = UIColor(red: 1.0,green: 1.0,blue: 1.0, alpha: 1.0)
        shapeRectSeq.lineWidth = 3
        //The shape is then added to the scene
        self.addChild(shapeRectSeq)
        
        //Sequencer information text
        seqInfo.text = "This is the Drums and Bass sequencer, touch the squares to play the sounds and they will repeat in a 8 bar loop. Use the clear button to turn the sounds off from the sequence line.";
        seqInfo.lineBreakMode = NSLineBreakMode.byWordWrapping
        seqInfo.numberOfLines = 0
        seqInfo.preferredMaxLayoutWidth = 250
        seqInfo.fontSize = 12
        //The position is set to be in the middle of the above shape
        seqInfo.position = CGPoint(x: shapeRectSeq.frame.midX, y: shapeRectSeq.frame.midY-25)
        seqInfo.fontColor = UIColor.black
        //The shape is then added to the scene
        self.addChild(seqInfo)
        
        //Shape with information about Keyboard
        let shapeRectKeyboard = SKShapeNode()
        shapeRectKeyboard.path = UIBezierPath(roundedRect: CGRect(x: -348, y:-220, width:240, height: 90), cornerRadius: 12).cgPath
        shapeRectKeyboard.position = CGPoint(x: frame.midX, y: frame.midY)
        //The colours are set using RGB values
        shapeRectKeyboard.fillColor = UIColor(red: 0.25,green: 0.55,blue: 1.0, alpha: 1.0)
        shapeRectKeyboard.strokeColor = UIColor(red: 1.0,green: 1.0,blue: 1.0, alpha: 1.0)
        shapeRectKeyboard.lineWidth = 3
        //The shape is then added to the scene
        self.addChild(shapeRectKeyboard)
        
        //Keyboard information text
        keyboardInfo.text = "This is the keyboard that you can use to play along with the sequences you create, just tap the buttons to begin and choose your voice via the buttons above.";
        keyboardInfo.lineBreakMode = NSLineBreakMode.byWordWrapping
        keyboardInfo.numberOfLines = 0
        keyboardInfo.preferredMaxLayoutWidth = 210
        keyboardInfo.fontSize = 12
        //The position is set to be in the middle of the above shape
        keyboardInfo.position = CGPoint(x: shapeRectKeyboard.frame.midX, y: shapeRectKeyboard.frame.midY-40)
        keyboardInfo.fontColor = UIColor.black
        //The shape is then added to the scene
        self.addChild(keyboardInfo)
        
        //Shape with information about Fxs
        let shapeRectFxs = SKShapeNode()
        shapeRectFxs.path = UIBezierPath(roundedRect: CGRect(x: 130, y:-30, width:200, height: 90), cornerRadius: 12).cgPath
        shapeRectFxs.position = CGPoint(x: frame.midX, y: frame.midY)
        shapeRectFxs.fillColor = UIColor(red: 0.25,green: 0.55,blue: 1.0, alpha: 1.0)
        shapeRectFxs.strokeColor = UIColor(red: 1.0,green: 1.0,blue: 1.0, alpha: 1.0)
        shapeRectFxs.lineWidth = 3
        //The shape is then added to the scene
        self.addChild(shapeRectFxs)
        
        //Fxs information text
        FxsInfo.text = "These are the post effects sliders, you can use them to manipulate your sound creation.";
        FxsInfo.lineBreakMode = NSLineBreakMode.byWordWrapping
        FxsInfo.numberOfLines = 0
        FxsInfo.preferredMaxLayoutWidth = 150
        FxsInfo.fontSize = 12
        //The position is set to be in the middle of the above shape
        FxsInfo.position = CGPoint(x: shapeRectFxs.frame.midX, y: shapeRectFxs
            .frame.midY-30)
        FxsInfo.fontColor = UIColor.black
        self.addChild(FxsInfo)
    
    
    }

}
