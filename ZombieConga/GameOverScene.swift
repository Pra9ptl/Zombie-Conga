//
//  GameOverScene.swift
//  ZombieConga
//
//  Created by MacStudent on 2019-06-10.
//  Copyright © 2019 Parrot. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    //Constructor
    
    //Mandatory Code
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //your code
    //----------------
    override func didMove(to view: SKView) {
        //sprites decalaration
        //1. image node
        let bgNode = SKSpriteNode(imageNamed: "YouLose")
        
        //set background image of the app
        
        //set position
         bgNode.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        //force the background to back of all the sprites
         bgNode.zPosition = -1
        
        addChild(bgNode)
        
    }
    
    
}
