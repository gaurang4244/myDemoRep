//
//  ViewController.swift
//  AugmentedGame
//
//  Created by Gaurang Patel on 09/07/17.
//  Copyright © 2017 Gaurang Patel. All rights reserved.
//

import UIKit
import ARKit


class ViewController: UIViewController {
    var timer : Int = 0
    var gameTimer: Timer!
    @IBOutlet weak var timerlabel: UILabel!
    var counter : Int = 0 {
        didSet {
            counterlabel.text = "\(counter)"
        }
    }
    @IBOutlet weak var sceneview: ARSCNView!
    
    @IBOutlet weak var counterlabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = SCNScene()
        sceneview.scene = scene
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let config = ARWorldTrackingSessionConfiguration()
        sceneview.session.run(config)
        
        
    }
    
    @objc func runTimedCode() {
        
        timer += 1
        timerlabel.text = String(timer)
        if timer == 15 {
            gameTimer.invalidate()
            let alert = UIAlertController(title: "Your Game is Over", message: "Quit The Game", preferredStyle: .alert)
            let Done = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(Done)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
    }
    func addobject() {
        let ship = SpaceShip()
        ship.loadobject()
        let xposi = randomnumber(lowerbound: -1.5, upperbound: 1.5)
        let yposi = randomnumber(lowerbound: -1.5, upperbound: 1.5)
        ship.position = SCNVector3(xposi,yposi,-1)
        sceneview.scene.rootNode.addChildNode(ship)
    }
    
    func randomnumber(lowerbound lower :Float, upperbound upper : Float) ->Float {
        return Float(arc4random()) / Float(UInt32.max) * (lower - upper) + upper
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: sceneview)
            let hitlist = sceneview.hitTest(location, options: nil)
            
            if let hitobject = hitlist.first {
                
                let node = hitobject.node
                if node.name == "ARShip" {
                    counter += 1
                   
                    node.removeFromParentNode()
                    addobject()
                }
                
            }
        }
    }
    
    @IBAction func PlayAct(_ sender: UIButton)
    {
        timer = 0
        counter = 0
        addobject()
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:  #selector(runTimedCode), userInfo: nil, repeats: true)
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

