//
//  GameScene.swift
//  ZombieConga
//
//  Created by Parrot on 2019-01-29.
//  Copyright © 2019 Parrot. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    //sprites decalaration
    //1. image node
    //let bgNode = SKSpriteNode(imageNamed: "background1")
    //add zombie sprite
    //1. image node
    let zombie = SKSpriteNode(imageNamed: "zombie1")
    //add enemy sprite
    //1. image node
    let enemy = SKSpriteNode(imageNamed: "enemy")
    
    let livesLabel = SKLabelNode()
    let scoreLabel = SKLabelNode()
   
    override func didMove(to view: SKView) {
        //code here
        
        //set background color to the app
        self.backgroundColor = SKColor.blue
        
        //set background image of the app
        
        //set position
       // bgNode.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        //force the background to back of all the sprites
       // bgNode.zPosition = -1
        
        //set position
        zombie.position = CGPoint(x: 400, y: 400)
        
        //set position
        enemy.position = CGPoint(x: self.size.width - 200, y: self.size.height/2)
        
        //add tp screen
        //addChild(bgNode)
        //add zombie to the screen
        addChild(zombie)
        //add zombie to the screen
        addChild(enemy)
        
        
        // MARK: Add HUDS to the game
        // --------------------------
        
        self.livesLabel.text = "Lives: \(self.lives)"
        self.livesLabel.fontColor = UIColor.yellow
        self.livesLabel.fontSize = 100;
        self.livesLabel.fontName = "Avenir-Bold"
        self.livesLabel.position = CGPoint(x: 200, y:self.size.height - 400)
        self.scoreLabel.text = "Lives: \(self.lives)"
        self.scoreLabel.fontColor = UIColor.yellow
        self.scoreLabel.fontSize = 100;
        self.scoreLabel.fontName = "Avenir-Bold"
        self.scoreLabel.position = CGPoint(x: self.size.width - 400, y:self.size.height - 400)
        
        
        //Move the enemy
        let m1 = SKAction.move(to: CGPoint(x: self.size.width/2, y: 400), duration: 2)
        let m2 = SKAction.move(to: CGPoint(x: 200, y: self.size.height/2), duration: 2)
        let m3 = SKAction.move(to: CGPoint(x: self.size.width - 400, y: self.size.height/2), duration: 2)
        let sequence:SKAction = SKAction.sequence([m1,m2,m1,m3])
        enemy.run(SKAction.repeatForever(sequence))
        
        
        
        //write the code to generate a cat every 3 seconds
        
        
        
    }
    var cats:[SKSpriteNode] = []
    let cat = SKSpriteNode(imageNamed: "cat")
    
    func makecat() {
        //lets add some cats
        
        
        
        let randX = Int(CGFloat(arc4random_uniform(UInt32(self.size.width - 150))))
        let randY = Int(CGFloat(arc4random_uniform(UInt32(self.size.height - 150))))
        
        cat.position = CGPoint(x: randX, y: randY)
        
        cats.append(cat)
        addChild(cat)
    }
    
    //Movement Flag
    var zombieDirection:String = "right"
    // MATH VARIABLES
    var xd:CGFloat = 0
    var yd:CGFloat = 0
    
    
    //Game Statistic variables
    var lives = 2
    var score = 0
    
    var timeOfLastUpdate:TimeInterval?
    
    override func update(_ currentTime: TimeInterval) {
        self.zombie.position.x = self.zombie.position.x + self.xd * 10
        self.zombie.position.y = self.zombie.position.y + self.yd * 10
        
        print("What is current time \(currentTime)")

        
        if(timeOfLastUpdate == nil){
            timeOfLastUpdate = currentTime
        }
        
        let timePassed = (currentTime - timeOfLastUpdate!)
        if(timePassed >= 3){
            timeOfLastUpdate = currentTime
            //make cat
            self.makecat()
        }
        
        // MARK: R1. dectect collisions between zombie and old lady
        // -----------------------------
        
        
        let collisionsDetected = self.zombie.intersects(self.enemy)
        if(collisionsDetected){
            print("Collision Detected!")
            
            // Palyer die
            self.lives = self.lives - 1
            
            //update lives label
            self.livesLabel.text = "Lives: \(self.lives)"
            
            if(self.lives == 0){
                //Display you lose scene
                
                let loseScene = GameOverScene(size: self.size)
                
                //Configure the lose
                loseScene.scaleMode = self.scaleMode
                
                //Make animation swapping to the lose scene
                let transitionEffect = SKTransition.flipHorizontal(withDuration: 1)
                self.view?.presentScene(loseScene, transition: transitionEffect)
            }
            
            // Player restarts in original position
            self.zombie.position = CGPoint(x:100, y:400)
            
            //restart his xd and yd
            self.xd = 0
            self.yd = 0
            
            
            // MARK: R1. dectect collisions between zombie and cat
            // --------------------------------------
            for (arrayIndex, cat) in cats.enumerated() {
                if(self.zombie.intersects(self.cat) == true){
                    print("Cat Collision Detected!")
                    
                    // 1. increase the score
                    self.score = self.score - 1
                    //update lives label
                    self.scoreLabel.text = "Score: \(self.score)"
                    // 2. remove cat from teh scene
                    // 2a. Remove from the array
                    self.cats.remove(at: arrayIndex)
                    // 2b. Remove from the screen
                    self.cat.removeFromParent()
                }
            }
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let locationTouched = touches.first
        
        if(locationTouched == nil)
        {
            //htis is error handling
            //sometimes the mouse detection doesn't work
            //and IOS can't get the position
            return
        }
        
        let mouseposition = locationTouched!.location(in: self)
        
        print("Mouse X? \(mouseposition.x)")
        print("Mouse y? \(mouseposition.y)")
        
        //calculate those math variable (d, xd, yd)
        //(x2 - x1)
        let a = mouseposition.x - self.zombie.position.x
        //(y2-y1)
        let b = mouseposition.y - self.zombie.position.y
        //d
        let d = sqrt((a*a) + (b*b))
        
        self.xd = a/d
        self.yd = b/d
    }
}
