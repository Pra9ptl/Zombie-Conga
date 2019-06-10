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
    
    // SPRITES
    let zombie = SKSpriteNode(imageNamed: "zombie1")
    let enemy = SKSpriteNode(imageNamed: "enemy")
    
    // GAME STAT SPRITES
    let livesLabel = SKLabelNode(text: "Lives: ")
    let scoreLabel = SKLabelNode(text: "Score: ")
    
    // MATH VARIABLES
    var xd:CGFloat = 0
    var yd:CGFloat = 0
    
    // GAME STATISTIC VARIABLES
    var lives = 2           // for testing, use a small number
    var score = 0
    
    
    override func didMove(to view: SKView) {
        
        // Set the background color of the app
        self.backgroundColor = SKColor.black;
        
        // MARK: Create a background image:
        // --------------------------
        
        // 1. create an image node
        let bgNode = SKSpriteNode(imageNamed: "background2")
        
        // 2. by default, image is shown in bottom left corner
        // I want to move image to middle
        // middle x: self.size.width/2
        // middle y: self.size.height/2
        bgNode.position = CGPoint(x:self.size.width/2,
                                  y:self.size.height/2)
        
        
        // Force the background to always appear at the back
        bgNode.zPosition = -1
        
        // MARK: Create a zombie sprite
        // --------------------------
        // 1. create an image node
        // ---> zombie is created as a global variable
        
        // 2. by default, image is shown at (400, 400)
        zombie.position = CGPoint(x:150,
                                  y:400)
        
        
        
        // MARK: Create a enemy sprite
        // --------------------------
        // 1. create an image node
        // --> check global variables for code
        
        
        // 2. position the enemy
        enemy.position = CGPoint(x:self.size.width - 200,
                                 y:self.size.height/2)
        
        
        
        // MARK: Add a lives label
        // ------------------------
        self.livesLabel.text = "Lives: \(self.lives)"
        self.livesLabel.fontName = "Avenir-Bold"
        self.livesLabel.fontColor = UIColor.yellow
        self.livesLabel.fontSize = 100;
        self.livesLabel.position = CGPoint(x:300,
                                           y:self.size.height-400)
        
        
        // MARK: Add a score label
        // ------------------------
        self.scoreLabel.text = "Score: \(self.score)"
        self.scoreLabel.fontName = "Avenir-Bold"
        self.scoreLabel.fontColor = UIColor.yellow
        self.scoreLabel.fontSize = 100;
        self.scoreLabel.position = CGPoint(x:800,
                                           y:self.size.height-400)
        
        
        // MARK: Add your sprites to the screen
        addChild(zombie)
        addChild(enemy)
        addChild(self.livesLabel)
        addChild(self.scoreLabel)
        
        
        // MARK: setup enemy movement
        // move to (w/2, 0)
        let m1 = SKAction.move(
            to: CGPoint(
                x:self.size.width/2,
                y:400),
            duration: 2)
        
        // move to (0,h/2)
        let m2 = SKAction.move(
            to: CGPoint(
                x:200,
                y:self.size.height/2),
            duration: 2)
        
        // move to (w, h/2)
        let m3 = SKAction.move(
            to: CGPoint(
                x:self.size.width - 200,
                y:self.size.height/2),
            duration: 2)
        
        
        let sequence:SKAction = SKAction.sequence([m1, m2, m1, m3])
        enemy.run(SKAction.repeatForever(sequence))
        
        
        // write the code to generate a cat every 3 seconds
        //        let generateCatsSequence = SKAction.sequence(
        //            [
        //                SKAction.run {
        //                    [weak self] in self?.makeCats()
        //                },
        //                SKAction.wait(forDuration: 1.5)
        //            ]
        //        )
        //        self.run(SKAction.repeatForever(generateCatsSequence))
        
        
    } //did move function
    
    
    // keep track of all the cat objects on the screen
    var cats:[SKSpriteNode] = []
    
    func makeCats() {
        // lets add some cats
        let cat = SKSpriteNode(imageNamed: "cat")
        
        // generate a random (x,y) for the cat
        let randX = Int(CGFloat(arc4random_uniform(UInt32(self.size.width-400))))
        let randY = Int(CGFloat(arc4random_uniform(UInt32(self.size.height-400))))
        
        cat.position = CGPoint(x:randX, y:randY)
        
        // add the cat to the scene
        addChild(cat)
        
        // add the cat to the cats array
        self.cats.append(cat)
        
        print("Where is cat? \(randX), \(randY)")
    }
    
    
    // variable to keep track of how much time has passed
    var timeOfLastUpdate:TimeInterval?
    
    override func update(_ currentTime: TimeInterval) {
        self.zombie.position.x = self.zombie.position.x + self.xd * 10
        self.zombie.position.y = self.zombie.position.y + self.yd * 10
        
        if (timeOfLastUpdate == nil) {
            timeOfLastUpdate = currentTime
        }
        // print a message every 3 seconds
        var timePassed = (currentTime - timeOfLastUpdate!)
        if (timePassed >= 1.5) {
            print("HERE IS A MESSAGE!")
            timeOfLastUpdate = currentTime
            // make a cat
            self.makeCats()
        }
        
        // MARK: Check for collisions
        // ---------------------------
        
        // MARK: R1: detect collisions between zombie and old lady
        var collisionDetected = self.zombie.intersects(self.enemy)
        if (collisionDetected == true) {
            // player dies
            // --------
            // 1. remove a life
            self.lives = self.lives - 1
            // 2. update the lives label
            self.livesLabel.text = "Lives: \(self.lives)"
            
            if (self.lives == 0) {
                // DISPLAY THE YOU LOSE SCENE
                let loseScene = GameOverScene(size: self.size)
                
                // CONFIGURE THE LOSE SCENE
                loseScene.scaleMode = self.scaleMode
                
                // MAKE AN ANIMATION SWAPPING TO THE LOSE SCENE
                let transitionEffect = SKTransition.flipHorizontal(withDuration: 2)
                self.view?.presentScene(loseScene, transition: transitionEffect)
                
            }
            
            
            
            
            
            // player restarts in original position
            // ---------------
            self.zombie.position = CGPoint(x:150,
                                           y:400)
            // restart his xd & yd
            // If you don't reset (xd,yd), the player
            // will move in his original direction after this collision
            self.xd = 0
            self.yd = 0
        }
        
        // MARK: R2: detect collisions between zombie and cat
        for (arrayIndex, cat) in cats.enumerated() {
            if (self.zombie.intersects(cat) == true) {
                print("CAT COLLISION DETECTED!")
                // 1. increase the score
                self.score = self.score + 1
                self.scoreLabel.text = "Score: \(self.score)"
                
                // 2. remove the cat from the scene
                print("Removing cat at position: \(arrayIndex)")
                // ---- 2a. remove from the array
                self.cats.remove(at: arrayIndex)
                // ---- 2b. remove from scene (undraw the cat)
                
                if (self.score == 5) {
                    // DISPLAY THE YOU WIN SCENE
                    let winScene = GameOverScene(size: self.size)
                    
                    // CONFIGURE THE WIN SCENE
                    winScene.scaleMode = self.scaleMode
                    
                    // MAKE AN ANIMATION SWAPPING TO THE WIN SCENE
                    let transitionEffect = SKTransition.flipHorizontal(withDuration: 2)
                    self.view?.presentScene(winScene, transition: transitionEffect)
                    
                }
                cat.removeFromParent()
            }
        }
            // MARK: R3: Check for collisions between zombie & wall
            if (self.zombie.position.x <= 50) {
            // left of screen
            self.xd = self.xd * -1
            }
            else if (self.zombie.position.x >= self.size.width-100) {
            // right of screen
                             self.xd = self.xd * -1
                      }
               else if (self.zombie.position.y <= 50) {
                         // botttom of screen
                              self.yd = self.yd * -1
                      }
                else if (self.zombie.position.y >= self.size.height-100)  {
                     // top of screen
                          self.yd = self.yd * -1
                 }
            
        
        
        
        //        if (self.zombie.intersects(self.cat) == true) {
        //            print("CAT COLLISION DETECTED!")
        //
        //        }
        
        
        
        
        
        
        
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let locationTouched = touches.first
        
        if (locationTouched == nil) {
            // This is error handling
            // Sometimes the mouse detection doesn't work properly
            // and IOS can't get the position.
            return
        }
        
        let mousePosition = locationTouched!.location(in:self)
        
        print("MOUSE X?  \(mousePosition.x)")
        print("MOUSE Y?  \(mousePosition.y)")
        print("------")
        
        // calculate those math variables (d, xd, yd)
        // (x2-x1)
        let a = mousePosition.x - self.zombie.position.x
        // (y2-y1)
        let b = mousePosition.y - self.zombie.position.y
        // d
        let d = sqrt( (a*a) + (b*b))
        
        self.xd = a/d
        self.yd = b/d
        
    }
    
    
    // MARK: end of file
    
}
