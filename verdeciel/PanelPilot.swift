//
//  PanelBeacon.swift
//  Verreciel
//
//  Created by Devine Lu Linvega on 2015-07-07.
//  Copyright (c) 2015 XXIIVV. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import Foundation

class PanelPilot : Panel
{
	var target:Location!
	var targetDirection = CGFloat()
	var targetDirectionIndicator = SCNNode()
	var activeDirectionIndicator = SCNNode()
	var staticDirectionIndicator = SCNNode()
	var eventsDirectionIndicator = SCNNode()
	
	var panelHead:SCNNode!
	var port:SCNPort!
	
	var panelFoot:SCNNode!
	var labelSecondary:SCNLabel!
	
	override func setup()
	{
		name = "pilot"
		
		interface.position = SCNVector3(x: 0, y: 0, z: templates.radius)
		
		panelHead = SCNNode()
		port = SCNPort(host: self)
		port.position = SCNVector3(x: 0, y: 0.4, z: templates.radius)
		label = SCNLabel(text: "pilot", scale: 0.1, align: alignment.center)
		label.position = SCNVector3(x: 0.05, y:0, z: templates.radius)
		panelHead.addChildNode(port)
		panelHead.addChildNode(label)
		addChildNode(panelHead)
		panelHead.eulerAngles.x += Float(degToRad(templates.titlesAngle))
		
		panelFoot = SCNNode()
		labelSecondary = SCNLabel(text: "0", scale: 0.1, align: alignment.center)
		labelSecondary.position = SCNVector3(x: 0.05, y: 0, z: templates.radius)
		panelFoot.addChildNode(labelSecondary)
		addChildNode(panelFoot)
		panelFoot.eulerAngles.x += Float(degToRad(-templates.titlesAngle))
		
		targetDirectionIndicator = SCNNode()
		targetDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.55, 0), nodeB: SCNVector3(0, 0.7, 0), color: white))
		interface.addChildNode(targetDirectionIndicator)
		
		activeDirectionIndicator = SCNNode()
		activeDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.4, -0.1), nodeB: SCNVector3(0, 0.55, -0), color: grey))
		interface.addChildNode(activeDirectionIndicator)
		
		staticDirectionIndicator = SCNNode()
		staticDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.2, -0.1), nodeB: SCNVector3(0, 0.4, -0), color: cyan))
		staticDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0, -0.2, -0.1), nodeB: SCNVector3(0, -0.4, -0), color: red))
		staticDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0.2, 0, -0.1), nodeB: SCNVector3(0.4, 0, -0), color: red))
		staticDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(-0.2, 0, -0.1), nodeB: SCNVector3(-0.4, 0, -0), color: red))
		interface.addChildNode(staticDirectionIndicator)
		
		eventsDirectionIndicator = SCNNode()
		eventsDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.2, -0.1), nodeB: SCNVector3(0.2, 0, -0), color: white))
		eventsDirectionIndicator.addChildNode(SCNLine(nodeA: SCNVector3(0, 0.2, -0.1), nodeB: SCNVector3(-0.2, 0, -0), color: white))
		interface.addChildNode(eventsDirectionIndicator)
		
		update()
	}
	
	override func start()
	{
		decals.opacity = 0
		interface.opacity = 0
		label.updateWithColor("--", color: grey)
		panelFoot.opacity = 0
	}
	
	override func setPower(power: Bool)
	{
		// Add progress bar during booting
		isPowered = power
		if power == true {
			port.enable()
			staticDirectionIndicator.opacity = 1
			label.updateWithColor(name!, color: white)
		}
		else{
			port.disable()
			staticDirectionIndicator.opacity = 0
			label.updateWithColor(name!, color: grey)
		}
	}
	
	override func touch(id:Int = 0)
	{
		
	}
	
	override func listen(event: Event)
	{
		target = event as! Location
	}
	
	override func fixedUpdate()
	{
		adjustAngle()
	}
	
	func adjustAngle()
	{
		if target == nil { return }
		
		let left = target.calculateAlignment(capsule.direction - 1)
		let right = target.calculateAlignment(capsule.direction + 1)
		
		targetDirection = target.align
		
		if Int(target.align) > 0 {
			if Int(left) < Int(right) {
				self.turnLeft(1 + (targetDirection % 1))
			}
			else if Int(left) > Int(right) {
				self.turnRight(1 + (targetDirection % 1))
			}
		}
		
		labelSecondary.update(String(format: "%.0f",target.align))
		
		let targetDirectionNormal = Double(Float(targetDirection)/180) * 1
		targetDirectionIndicator.rotation = SCNVector4Make(0, 0, 1, Float(M_PI * targetDirectionNormal))
		let staticDirectionNormal = Double(Float(capsule.direction)/180) * 1
		staticDirectionIndicator.rotation = SCNVector4Make(0, 0, 1, Float(M_PI * staticDirectionNormal))
		let eventsDirectionNormal = Double(Float(targetDirection - capsule.direction)/180) * 1
		eventsDirectionIndicator.rotation = SCNVector4Make(0, 0, 1, Float(M_PI * eventsDirectionNormal))
	}
	
	func turnLeft(deg:CGFloat)
	{
		capsule.direction = capsule.direction - deg
		capsule.direction = capsule.direction % 360
	}
	
	func turnRight(deg:CGFloat)
	{
		capsule.direction = capsule.direction + deg
		capsule.direction = capsule.direction % 360
	}
}