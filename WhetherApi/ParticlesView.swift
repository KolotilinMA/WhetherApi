//
//  ParticlesView.swift
//  WhetherApi
//
//  Created by Михаил on 15/06/2019.
//  Copyright © 2019 Михаил. All rights reserved.
//

import UIKit
import SpriteKit

class ParticlesView: SKView {
    
    override func didMoveToSuperview() {
        
        let scene = SKScene(size: self.frame.size)
        scene.backgroundColor = UIColor.clear
        
        self.allowsTransparency = true
        self.backgroundColor = UIColor.clear

        self.presentScene(scene)
        if WeatherIconManager.Rain.rawValue == "rain" {
            return
        } else {
            if let particles = SKEmitterNode(fileNamed: "ParticleScene.sks") {
                particles.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height)
                particles.particlePositionRange = CGVector(dx: self.bounds.size.width, dy: 0)
                scene.addChild(particles)
            }
        }
    }
}
