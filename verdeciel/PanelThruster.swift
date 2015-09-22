//
//  SCNThruster.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-06.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelThruster : SCNNode
{
	var nameLabel = SCNNode()
	
	var accelerate:SCNTrigger!
	var decelerate:SCNTrigger!
	
	var line1:SCNLine!
	var line2:SCNLine!
	var line3:SCNLine!
	var line4:SCNLine!
	
	var maxSpeed:Int = 0
	var speed:Int = 0
	
	// Ports
	
	var input:SCNPort!
	
	override init()
	{
		super.init()
		
		name = "thruster"
		addInterface()
		
		self.position = SCNVector3(x: 0, y: 0, z: lowNode[7].z - 0.2)
		
		draw()
	}

	func addInterface()
	{
		let scale:Float = 0.8
		
		nameLabel = SCNLabel(text: self.name!, scale: 0.1, align: alignment.center)
		nameLabel.position = SCNVector3(x: 0, y: highNode[7].y * scale, z: 0)
		self.addChildNode(nameLabel)
		
		// Lines
		line1 = SCNLine(nodeA: SCNVector3(-0.5, -0.3, 0), nodeB: SCNVector3(0.5, -0.3, 0), color: grey)
		line2 = SCNLine(nodeA: SCNVector3(-0.5, -0.1, 0), nodeB: SCNVector3(0.5, -0.1, 0), color: grey)
		line3 = SCNLine(nodeA: SCNVector3(-0.5, 0.1, 0), nodeB: SCNVector3(0.5, 0.1, 0), color: white)
		line4 = SCNLine(nodeA: SCNVector3(-0.5, 0.3, 0), nodeB: SCNVector3(0.5, 0.3, 0), color: white)
		
		self.addChildNode(line1)
		self.addChildNode(line2)
		self.addChildNode(line3)
		self.addChildNode(line4)
		
		// Controls
		self.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.7, 0), nodeB: SCNVector3(0.5, 0.5, 0), color: cyan))
		self.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.7, 0), nodeB: SCNVector3(-0.5, 0.5, 0), color: cyan))
		self.addChildNode(SCNLine(nodeA: SCNVector3(0, -0.7, 0), nodeB: SCNVector3(0.5, -0.5, 0), color: red))
		self.addChildNode(SCNLine(nodeA: SCNVector3(0, -0.7, 0), nodeB: SCNVector3(-0.5, -0.5, 0), color: red))
		
		// Triggers
		accelerate = SCNTrigger(host: self, size: 1, operation: true)
		accelerate.position = SCNVector3(0, 0.5, 0)
		decelerate = SCNTrigger(host: self, size: 1, operation: false)
		decelerate.position = SCNVector3(0, -0.5, 0)
		
		self.addChildNode(accelerate)
		self.addChildNode(decelerate)
		
		// Ports
		
		input = SCNPort(host: self,polarity: false)
		input.position = SCNVector3(x: lowNode[7].x * scale + 0.7, y: highNode[7].y * scale, z: 0)
		self.addChildNode(input)
	}
	
	override func bang(param:Bool = true)
	{
		if param == true {
			speedUp()
		}
		else{
			speedDown()
		}
	}
	
	func speedUp()
	{
		if speed <= maxSpeed {
			speed += 1
		}
		draw()
	}
	
	func speedDown()
	{
		if speed >= 1 {
			speed -= 1
		}
		draw()
	}
	
	func draw()
	{
		maxSpeed = 3
		
		if speed >= maxSpeed {
			speed = maxSpeed
		}
		
		line1.opacity = 1
		line2.opacity = 1
		line3.opacity = 1
		line4.opacity = 1
		
		line1.color(grey)
		line2.color(grey)
		line3.color(grey)
		line4.color(grey)
		
		if speed > 0 { line1.color(white) }
		if speed > 1 { line2.color(white) }
		if speed > 2 { line3.color(white) }
		if speed > 3 { line4.color(white) }
		
		if maxSpeed < 4 { line4.opacity = 0 }
		if maxSpeed < 3 { line3.opacity = 0 }
		if maxSpeed < 2 { line2.opacity = 0 }
		if maxSpeed < 1 { line1.opacity = 0 }
	}
	
	override func update()
	{
		/*
		if speed > 0
		{
			let speed:Float = 0.01
			let angle:Float = Float((capsule.direction) % 360)
			
			
			let angleRad = ( Double(angle) / 180.0 * M_PI)
			print("\(angle) -> \(angleRad)")
			
			
			capsule.location.x += CGFloat(speed) * CGFloat(cos(angleRad))
			capsule.location.y += CGFloat(speed) * CGFloat(sin(angleRad))
			radar.update()
		}
*/
		
		let speed:Float = 0.005
		let angle:Float = Float((capsule.direction) % 360)
		
		let angleRad = ( Double(angle) / 180.0 * M_PI)
		
		capsule.location.x += CGFloat(speed) * CGFloat(sin(angleRad))
		capsule.location.y += CGFloat(speed) * CGFloat(cos(angleRad))
		
		radar.update()
	}
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented")
	}
}