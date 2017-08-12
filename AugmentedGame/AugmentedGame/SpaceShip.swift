//
//  SpaceShip.swift
//  AugmentedGame
//
//  Created by Gaurang Patel on 09/07/17.
//  Copyright © 2017 Gaurang Patel. All rights reserved.
//

import ARKit

class SpaceShip: SCNNode {
    
    func loadobject() {
guard let virtualObjectscene = SCNScene(named : "art.scnassets/ship.scn")  else {return }
        
        let wrappernode = SCNNode()
        for child in virtualObjectscene.rootNode.childNodes {
            wrappernode.addChildNode(child)
        }
        
        
        self.addChildNode(wrappernode)
        
        
        
        
        
    }
    
    
    
    
    
}
