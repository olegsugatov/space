//
//  GameViewController.swift
//  Space
//
//  Created by oleg.kipling on 23.07.14.
//  Copyright (c) 2014 oleg.kipling. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

extension SKNode {
    class func unarchiveFromFile(_ file : NSString) -> SKNode? {
        
        let path = Bundle.mainBundle().pathForResource(file, ofType: "sks")
        
        var sceneData = Data.dataWithContentsOfFile(path, options: .DataReadingMappedIfSafe, error: nil)
        var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
        
        archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
        let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
        archiver.finishDecoding()
        return scene
    }
}

class GameViewController: UIViewController {

    var backgroundMusicPlayer:AVAudioPlayer = AVAudioPlayer ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /* if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            // Configure the view.
            let skView = self.view as SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }*/
    }

    override func viewWillLayoutSubviews() {
        
        var bgMusicURL:URL = Bundle.mainBundle().URLForResource("bgmusic", withExtension: "mp3")
        backgroundMusicPlayer = AVAudioPlayer(contentsOfURL: bgMusicURL, error: nil)
        backgroundMusicPlayer.numberOfLoops = -1
        backgroundMusicPlayer.prepareToPlay()
        backgroundMusicPlayer.play()
        
        var skView:SKView = self.view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        var scene:SKScene = GameScene.sceneWithSize(skView.bounds.size)
        scene.scaleMode = SKSceneScaleMode.aspectFill
        skView.presentScene(scene)
    }
        
        
    override var shouldAutorotate : Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.toRaw())
        } else {
            return Int(UIInterfaceOrientationMask.All.toRaw())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}
